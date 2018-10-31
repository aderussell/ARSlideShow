//
//  ARSlideShowTransitionAnimating.h
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

#import <UIKit/UIKit.h>

/**
 *  The protocol which defines the interface for a transition animator which will control displaying of image views along with any animations.
 *
 *  A transition animator is responsible for adding the `targetImageView` to and removing the `existingImageView` from the `containerView`.
 */
@protocol ARSlideShowTransitionAnimating <NSObject>


/**
 *  Initializes a transition animator with the specified image views to be animated and the container view where they will be shown and animated.
 *
 *  @param existingImageView The image view which is currently being displayed in the specified containerView. This must be removed from the containerView, by the created instance, by the end of the transition.
 *  @param targetImageView The image view to be displayed in the specified containerView. This must be added to the containerView and not removed at the end of the transition.
 *  @param containerView The view where the existing and target image views to be displayed. This is the area where any transition can occur.
 *
 *  @return The newly initialized transition animator.
 */
- (instancetype)initWithExistingImageView:(UIView *)existingImageView
                          targetImageView:(UIView *)targetImageView
                            containerView:(UIView *)containerView;


/**
 *  Starts the transition of the image views.
 *
 *  @param completionHandler A block which will be called when the transition is complete. It has a single paramter `didComplete` which indicates if the animation successfully completed or was stopped early.
 */
- (void)startTransition:(void(^)(BOOL didComplete))completionHandler;

@end
