//
//  ARSlideShowController.h
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
#import "ARSlideShowImageProviding.h"
#import "ARSlideShowMusicControlling.h"
#import "ARSlideShowTransitionAnimating.h"


@class ARSlideShowController;

/**
 *  The protocol which defines the interface for a delegate to a slide show controller.
 *  The delegate will be notified when the slide show has reached the end of the images provided by its imageProvider.
 */
@protocol ARSlideShowControllerDelegate <NSObject>

/**
 *  Notifies the receiver that the specified slide show controller has now displayed all of the images provided by its `imageProvider` and whether, or not, it will display them all again or will stop displaying anything.
 *
 *  This allows any needed actions to be taken by the receiver then the slide show has completed.
 *  An example whould be to stop displaying the slideshow and releasing all the resources no longer needed.
 *
 *  @param slideShowController The slide show that has reached the end.
 *  @param willRepeat Whether, or not, the images in the slide show will be repeated again.
 */
- (void)slideShowControllerDidEnd:(nonnull ARSlideShowController *)slideShowController willRepeat:(BOOL)willRepeat;

@end


/**
 *  A slide show controller which will control the flow of presenting a series of images as a slide show with animated transitions and background music.
 *
 *  The controller will take the images supplied by a specified ARSlideShowImageProviding image provider and display then on a specified conytainerView. The transitions will be provided by the same image provider and will be triggered by the slide show controller.
 *  If a music controller is specified then this will be used by the controller to start and stop music being played along with displaying the images.
 */
@interface ARSlideShowController : NSObject


/**
 *  Initializes and returns a new slide shown controller which will manage a slide show displaying the images provided by the specified imageProvider on the specified containerView.

 @param imageProvider The image provider which will display all the images and transition animators to be used in the slide shown.
 @param containerView The view upon which all of the images and transitions will be dispalyed.
 @param musicController An optional music controller which can play audio along with the slide show.
 @return The newly initialized slide show controller.
 */
- (nonnull instancetype)initWithImageProvider:(nonnull id<ARSlideShowImageProviding>)imageProvider
                                containerView:(nonnull UIView *)containerView
                              musicController:(nullable id<ARSlideShowMusicControlling>)musicController;


/**
 *  The music controller that will manage audio played with the slide show.
 *  This is optional.
 */
@property (nonatomic, strong, nullable, readonly) id<ARSlideShowMusicControlling> musicController;

/**
 *  The object that will provide all the images to be displayed in the slide show as well as all of the transitions to use between them.
 */
@property (nonatomic, strong, nonnull, readonly) id<ARSlideShowImageProviding> imageProvider;

/**
 *  The view upon which the images and transitions will be displayed.
 */
@property (nonatomic, strong, nonnull, readonly) UIView *containerView;

/**
 *  The content mode for the images views holding the images being displayed.
 */
@property (nonatomic) UIViewContentMode imageContentMode;


/**
 *  The delegate for the slide show controller.
 *  THe object set as the delegate will be notified when the slide show controller reaches the end of the images supplied by the `imageProvider`.
 */
@property (nonatomic, weak, nullable) id<ARSlideShowControllerDelegate> delegate;



/** @name Slide show options */

/**
 *  Whether, or not, the slide show will repeat when it reaches the end of the images from the `imageProvider`.
 *  The default is `NO`.
 */
@property (getter=willRepeat) BOOL repeat;

/**
 *  The time that the images is shown before the next transition animation is started.
 *  The default is 5.0 seconds.
 */
@property (nonatomic) NSTimeInterval displayDuration;



/** @name Layout */

/**
 *  Forces a layout of the displayed image view to fit the frame of the `containerView`.
 */
- (void)performLayout;



/** @name Controlling the slide show */

/**
 *  Starts or resumes the slide show and starts the `musicController`.
 */
- (void)beginSlideShow;

/**
 *  Pauses transitioning to new images given by the `imageProvider` and stop the `musicController`.
 */
- (void)pauseSlideShow;

@end
