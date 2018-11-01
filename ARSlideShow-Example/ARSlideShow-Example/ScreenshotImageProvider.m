//
//  ScreenshotImageProvider.m
//  ARSlideShow-Example
//
//  Created by Adrian Russell on 31/10/2018.
//  Copyright © 2018 Adrian Russell. All rights reserved.
//

#import "ScreenshotImageProvider.h"
#import "NoAnimationTransitionAnimator.h"
#import "SlideTransitionAnimator.h"
#import "BounceTransitionAnimator.h"
#import "FlipTransitionAnimator.h"
#import "CubeTransitionAnimator.h"
#import "FadeTransitionAnimator.h"
#import "IrisTransitionAnimation.h"
#import "ExplosionTransitionAnimation.h"

@interface ScreenshotImageProvider ()
//@property (nonatomic, strong, nonnull) NSArray<UIImage *> *images;
@end

@implementation ScreenshotImageProvider

- (NSUInteger)numberOfImages
{
    return 16;
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    return index % 2 ? [UIImage imageNamed:@"Frog"] : [UIImage imageNamed:@"Brushes"];
}

- (nullable id<ARSlideShowTransitionAnimating>)transitionAnimationForIndex:(NSUInteger)index
                                                              existingView:(UIView *)existingImageView
                                                            presentingView:(UIView *)imageView
                                                             containerView:(UIView *)containerView
{
    if (index == 1) {
        return [[NoAnimationTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    } else if (index == 3) {
        return [[FadeTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    } else if (index == 5) {
        BounceTransitionAnimator *slide = [[BounceTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
        slide.slideDirection = SlideDirectionFromTop;
        return slide;
    } else if (index == 7) {
        return [[FlipTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    } else if (index == 9) {
        return [[IrisTransitionAnimation alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    } else if (index == 11) {
        SlideTransitionAnimator *slide = [[SlideTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
        slide.slideDirection = SlideDirectionFromTop;
        return slide;
    } else if (index == 13) {
        return [[CubeTransitionAnimator alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    } else if (index == 15) {
        return [[ExplosionTransitionAnimation alloc] initWithExistingView:existingImageView targetView:imageView containerView:containerView];
    }
    
    return nil;
}


@end
