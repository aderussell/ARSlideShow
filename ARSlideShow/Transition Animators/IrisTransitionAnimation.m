//
//  IrisTransitionAnimation.m
//
//  Created by Adrian Russell on 12/12/2017.
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

#import "IrisTransitionAnimation.h"

@interface IrisTransitionAnimation () <CAAnimationDelegate>
@property (nonatomic, copy, nullable) void(^completionHandler)(BOOL didComplete);
@end

@implementation IrisTransitionAnimation

- (instancetype)initWithExistingImageView:(UIView *)existingImageView
                          targetImageView:(UIView *)targetImageView
                            containerView:(UIView *)containerView
{
    if (self = [super init]) {
        _fromView      = existingImageView;
        _toView        = targetImageView;
        _containerView = containerView;
        
        _duration = 0.7;
        _irisAnchorPoint = CGPointMake(0.5, 0.5);
    }
    return self;
}


- (void)startTransition:(void(^)(BOOL didComplete))completionHandler
{
    self.completionHandler = completionHandler;
    
    self.toView.bounds = self.containerView.bounds;
    
    self.toView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.toView];
    
    CGPoint wipeOrigin = CGPointMake(self.irisAnchorPoint.x * self.toView.frame.size.width, self.irisAnchorPoint.y * self.toView.frame.size.height);
    
    
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(wipeOrigin.x, wipeOrigin.y, 1, 1)];
    CGPoint extremePoint = CGPointMake(wipeOrigin.x - 0, wipeOrigin.y - CGRectGetHeight(self.toView.bounds));
    CGFloat radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(wipeOrigin.x - radius, wipeOrigin.y - radius, radius*2, radius*2)];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.path = circleMaskPathFinal.CGPath;
    self.toView.layer.mask = maskLayer;
    
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue   = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration  = self.duration;
    maskLayerAnimation.delegate  = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}


#pragma mark - CAAnimationDelegate methods

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.toView.layer.mask = nil;
    
    [self.fromView removeFromSuperview];
    self.completionHandler(YES);
}


@end
