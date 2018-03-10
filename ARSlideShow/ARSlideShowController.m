//
//  ARSlideShowController.m
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

#import "ARSlideShowController.h"
#import "NoAnimationTransitionAnimator.h"

@interface ARSlideShowController ()
@property (nonatomic) NSUInteger currentImageIndex;
@property (nonatomic) UIImageView *presentedImageView;
@property (nonatomic, getter=isAnimating) BOOL animating;
@end

@implementation ARSlideShowController

- (nonnull instancetype)initWithImageProvider:(nonnull id<ARSlideShowImageProviding>)imageProvider
                                containerView:(nonnull UIView *)containerView
                              musicController:(nullable id<ARSlideShowMusicControlling>)musicController
{
    if (self = [super init]) {
        _imageProvider    = imageProvider;
        _containerView    = containerView;
        _musicController  = musicController;
        _displayDuration  = 5.0;
        _imageContentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}


- (void)beginSlideShow
{
    self.animating = YES;
    
    if (self.imageProvider.numberOfImages > self.currentImageIndex) {
        UIImage *image = [self.imageProvider imageAtIndex:self.currentImageIndex];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = self.containerView.backgroundColor;
        imageView.contentMode = self.imageContentMode;
        self.presentedImageView = imageView;
        imageView.frame = self.containerView.bounds;
        [self.containerView addSubview:self.presentedImageView];
        
        [self.musicController startMusic];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.displayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentImageIndex++;
            [self loadNextImage];
        });
    }
}

- (void)pauseSlideShow
{
    self.animating = NO;
    
    [self.musicController endMusic];
}


- (void)loadNextImage
{
    if (!self.isAnimating) {
        return;
    }
    
    if (self.imageProvider.numberOfImages > self.currentImageIndex) {
        UIImage *image = [self.imageProvider imageAtIndex:self.currentImageIndex];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = self.containerView.backgroundColor;
        imageView.contentMode = self.imageContentMode;
        imageView.frame = self.containerView.bounds;
        
        id<ARSlideShowTransitionAnimating> transitionAnimator = nil;
        if ([self.imageProvider respondsToSelector:@selector(transitionAnimationForIndex:existingImageView:presentingImageView:containerView:)]) {
            transitionAnimator = [self.imageProvider transitionAnimationForIndex:self.currentImageIndex existingImageView:self.presentedImageView presentingImageView:imageView containerView:self.containerView];
        }
        if (!transitionAnimator) {
            transitionAnimator = [[NoAnimationTransitionAnimator alloc] initWithExistingImageView:self.presentedImageView targetImageView:imageView containerView:self.containerView];
        }
        
        self.presentedImageView = imageView;
        //[self.containerView addSubview:self.presentedImageView];
        
        [transitionAnimator startTransition:^(BOOL didComplete) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.displayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _currentImageIndex++;
                [self loadNextImage];
            });
        }];
        
        
        
    } else {
        // DID END
        
        self.currentImageIndex = 0;
        
        if ([self.delegate respondsToSelector:@selector(slideShowControllerDidEnd:willRepeat:)]) {
            [self.delegate slideShowControllerDidEnd:self willRepeat:self.willRepeat];
        }
        
        if (self.willRepeat) {
            [self loadNextImage];
        }
    }
}


#pragma mark - Layout

- (void)performLayout
{
    self.presentedImageView.frame = self.containerView.frame;
}



@end
