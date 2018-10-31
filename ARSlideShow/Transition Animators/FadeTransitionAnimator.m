//
//  FadeTransitionAnimator.m
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

#import "FadeTransitionAnimator.h"

@implementation FadeTransitionAnimator

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
    
    
    [UIView animateWithDuration:self.duration animations:^{
        
        self.fromView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self.fromView removeFromSuperview];
        completionHandler(YES);
    }];
}

@end
