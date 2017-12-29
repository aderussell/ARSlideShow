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


// looks after the audioController

// controls getting the next image and animator and displaying the image

// controls repeating and/or ending the slideshow




@interface ARSlideShowController : NSObject

- (nonnull instancetype)initWithImageProvider:(nonnull id<ARSlideShowImageProviding>)imageProvider
                                containerView:(nonnull UIView *)containerView
                              musicController:(nullable id<ARSlideShowMusicControlling>)musicController;

@property (nonatomic, strong, nullable, readonly) id<ARSlideShowMusicControlling> musicController;

@property (nonatomic, strong, nonnull, readonly) id<ARSlideShowImageProviding> imageProvider;


@property (nonatomic, strong, nonnull, readonly) UIView *containerView;

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



/** @name Controlling the slide show */


- (void)beginSlideShow;

- (void)pauseSlideShow;

@end
