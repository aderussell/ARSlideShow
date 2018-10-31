//
//  CubeTransitionAnimator.m
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

#import "CubeTransitionAnimator.h"

@implementation CubeTransitionAnimator

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
    
    BOOL reverse = NO;
    CGFloat direction = (reverse) ? -1.0 : 1.0;
    CGFloat consty  = -0.005;
    
    self.toView.layer.anchorPoint   = CGPointMake(direction == 1 ? 0 : 1, 0.5);
    self.fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5);
    
    CATransform3D viewFromTransform = CATransform3DMakeRotation(direction * M_PI_2, 0.0, 1.0, 0.0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(-direction * M_PI_2, 0.0, 1.0, 0.0);
    viewFromTransform.m34 = consty;
    viewToTransform.m34 = consty;
    
    self.containerView.transform = CGAffineTransformMakeTranslation(direction * self.containerView.frame.size.width / 2.0, 0);
    self.toView.layer.transform = viewToTransform;
    [self.containerView addSubview:self.toView];
    
    [UIView animateWithDuration:self.duration animations:^{
        
        self.containerView.transform = CGAffineTransformMakeTranslation(-direction * self.containerView.frame.size.width / 2.0, 0);
        self.fromView.layer.transform = viewFromTransform;
        self.toView.layer.transform = CATransform3DIdentity;
        
        
    } completion:^(BOOL finished) {
        
        self.containerView.transform = CGAffineTransformIdentity;
        self.fromView.layer.transform = CATransform3DIdentity;
        self.toView.layer.transform = CATransform3DIdentity;
        self.fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self.fromView removeFromSuperview];
        completionHandler(YES);
    }];
}

@end
