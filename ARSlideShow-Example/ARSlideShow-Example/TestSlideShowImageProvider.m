//
//  StandardSlideShowImageProvider.m
//  SlideShow
//
//  Created by Adrian Russell on 28/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import "TestSlideShowImageProvider.h"
#import "SlideTransitionAnimator.h"
#import "SpinTransitionAnimator.h"
#import "CubeTransitionAnimator.h"
#import "FadeTransitionAnimator.h"
#import "IrisTransitionAnimation.h"
#import "ExplosionTransitionAnimation.h"

@interface TestSlideShowImageProvider ()
@property (nonatomic, strong, nonnull) NSArray<UIImage *> *images;
@end

@implementation TestSlideShowImageProvider

- (instancetype)initWithImages:(NSArray<UIImage *> *)images
{
    if (self = [super init]) {
        _images = [images copy];
    }
    return self;
}

- (NSUInteger)numberOfImages
{
    return self.images.count;
}

- (UIImage *)imageAtIndex:(NSUInteger)index
{
    return self.images[index];
}

- (nullable id<ARSlideShowTransitionAnimating>)transitionAnimationForIndex:(NSUInteger)index
                                                         existingImageView:(UIImageView *)existingImageView
                                                       presentingImageView:(UIImageView *)imageView
                                                             containerView:(UIView *)containerView
{
    if (index % 5 == 1) {
        return [[FadeTransitionAnimator alloc] initWithExistingImageView:existingImageView targetImageView:imageView containerView:containerView];
    } else if (index % 5 == 2) {
        SlideTransitionAnimator *slide = [[SlideTransitionAnimator alloc] initWithExistingImageView:existingImageView targetImageView:imageView containerView:containerView];
        slide.slideDirection = SlideDirectionFromBottom;
        return slide;
    } else if (index % 5 == 3) {
        return [[ExplosionTransitionAnimation alloc] initWithExistingImageView:existingImageView targetImageView:imageView containerView:containerView];
    } else if (index % 5 == 4) {
        return [[IrisTransitionAnimation alloc] initWithExistingImageView:existingImageView targetImageView:imageView containerView:containerView];
    } else {
        return [[SpinTransitionAnimator alloc] initWithExistingImageView:existingImageView targetImageView:imageView containerView:containerView];
    }
    
    return nil;
}

- (id)interstitialAnimationForIndex:(NSUInteger)index
{
    return nil;
}

@end
