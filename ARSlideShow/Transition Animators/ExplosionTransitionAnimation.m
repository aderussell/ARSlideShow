//
//  ExplosionTransitionAnimation.m
//
//  Created by Adrian Russell on 22/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "ExplosionTransitionAnimation.h"

@interface ExplosionTransitionAnimation ()
@property (nonatomic, strong, nullable) NSArray<UIView *> *views;
@end

@implementation ExplosionTransitionAnimation

- (instancetype)initWithExistingImageView:(UIView *)existingImageView
                          targetImageView:(UIView *)targetImageView
                            containerView:(UIView *)containerView
{
    if (self = [super init]) {
        _fromView      = existingImageView;
        _toView        = targetImageView;
        _containerView = containerView;
        
        _duration = 0.7;
    }
    return self;
}


- (void)startTransition:(void(^)(BOOL didComplete))completionHandler
{
    self.toView.bounds = self.containerView.bounds;
    
    self.toView.frame = self.containerView.bounds;
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    
    
    CGSize size = self.fromView.frame.size;
    
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    
    // snapshot the from view, this makes subsequent snaphots more performant
    UIView *fromViewSnapshot = self.fromView;
    
    // create a snapshot for each of the exploding pieces
    for (CGFloat x=0; x < size.width; x+= size.width / xFactor) {
        for (CGFloat y=0; y < size.height; y+= size.height / yFactor) {
            CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [self.containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [self.fromView removeFromSuperview];
    
    // animate
    [UIView animateWithDuration:self.duration animations:^{
        for (UIView *view in snapshots) {
            CGFloat xOffset = [self randomFloatBetween:-100.0 and:100.0];
            CGFloat yOffset = [self randomFloatBetween:-100.0 and:100.0];
            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
            view.alpha = 0.0;
            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 0.01, 0.01);
        }
    } completion:^(BOOL finished) {
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        
        completionHandler(YES);
    }];
}


- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end
