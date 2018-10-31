//
//  ScreenshotImageProvider.h
//  ARSlideShow-Example
//
//  Created by Adrian Russell on 31/10/2018.
//  Copyright © 2018 Adrian Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARSlideShowImageProviding.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScreenshotImageProvider : NSObject <ARSlideShowImageProviding>

- (NSUInteger)numberOfImages;

- (UIImage *)imageAtIndex:(NSUInteger)index;


- (nullable id<ARSlideShowTransitionAnimating>)transitionAnimationForIndex:(NSUInteger)index
                                                              existingView:(UIView *)existingImageView
                                                            presentingView:(UIView *)imageView
                                                             containerView:(UIView *)containerView;

@end

NS_ASSUME_NONNULL_END
