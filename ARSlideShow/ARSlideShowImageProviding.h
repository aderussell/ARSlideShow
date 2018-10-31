//
//  ARSlideShowImageProviding.h
//
//  Created by Adrian Russell on 11/12/2017.
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

#import <UIKit/UIKit.h>
#import "ARSlideShowTransitionAnimating.h"

/**
 *  The protocol which defines the interface for an object which will provide all of the images and the transition animations to a slide show controller.
 */
@protocol ARSlideShowImageProviding <NSObject>

/**
 *  The number of images that are to be shown in the slideshow.
 */
@property (nonatomic, readonly) NSUInteger numberOfImages;


/**
 *  Returns the image to be displayed in the slide show at the specified index.
 *
 *  @param index The index of the image to return.
 *  @return The image to be displayed at the specified index.
 */
- (nonnull UIImage *)imageAtIndex:(NSUInteger)index;


/**
 *  The transition animator which should be used to transition between the specified image views.
 *  If nil is returned by this method then the slide show controller will use an instance of `NoAnimationTransitionAnimator` and no animation will occur.
 *
 *  @param index          The index of the image which is going to be displayed with the returned animation.
 *  @param existingView   The view which contains the image being currently displayed.
 *  @param presentingView The view which contains the image which is going to be displayed.
 *  @param containerView  The view where the image views are displayed and where the image will be performed.
 *
 *  @return The transition animator to be used, or nil if the default should be used.
 */
- (nullable id<ARSlideShowTransitionAnimating>)transitionAnimationForIndex:(NSUInteger)index
                                                              existingView:(nonnull UIView *)existingView
                                                            presentingView:(nonnull UIView *)presentingView
                                                             containerView:(nonnull UIView *)containerView;

@end
