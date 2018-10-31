//
//  StandardSlideShowImageProvider.h
//  SlideShow
//
//  Created by Adrian Russell on 28/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARSlideShowImageProviding.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestSlideShowImageProvider : NSObject <ARSlideShowImageProviding>

- (instancetype)initWithImages:(NSArray<UIImage *> *)images;

- (NSUInteger)numberOfImages;

- (UIImage *)imageAtIndex:(NSUInteger)index;


- (nullable id<ARSlideShowTransitionAnimating>)transitionAnimationForIndex:(NSUInteger)index
                                                         existingView:(UIView *)existingImageView
                                                       presentingView:(UIView *)imageView
                                                             containerView:(UIView *)containerView;

- (nullable id)interstitialAnimationForIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
