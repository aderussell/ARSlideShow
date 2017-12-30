//
//  SlideShowViewController.m
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import "SlideShowViewController.h"
#import "ARSlideShowController.h"
#import "TestImagesSlideShowImagePreparation.h"
#import "DownloadingSlideShowImagePreparation.h"
#import "TestSlideShowImageProvider.h"

@interface SlideShowViewController () <ARSlideShowControllerDelegate>
@property (nonatomic, strong, nullable) ARSlideShowController *slideShowController;

@end

@implementation SlideShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createSlideShowWithTestProvider];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


#pragma mark - Creating Slide Shows

- (void)createSlideShowWithTestProvider
{
    // prepare the images to be shown in the slide show
    TestImagesSlideShowImagePreparation *imagePreparation = [[TestImagesSlideShowImagePreparation alloc] init];
    [imagePreparation prepareImages:nil];
    
    TestSlideShowImageProvider *imageProvider = [[TestSlideShowImageProvider alloc] initWithImages:imagePreparation.images];
    
    self.slideShowController = [[ARSlideShowController alloc] initWithImageProvider:imageProvider containerView:self.view musicController:nil];
    self.slideShowController.repeat   = YES;
    self.slideShowController.delegate = self;
    
    [self.slideShowController beginSlideShow];
}

- (void)createSlideShowWithDownloadProvider
{
    NSArray<NSURL *> *urls = @[[NSURL URLWithString:@"https://www.planwallpaper.com/static/images/computer-desktop-wallpapers-3d.jpg"],
                               [NSURL URLWithString:@"https://www.planwallpaper.com/static/images/Desktop-Wallpaper-HD7.jpg"],
                               [NSURL URLWithString:@"https://www.planwallpaper.com/static/images/desktop-wallpaper-green.jpg"],
                               [NSURL URLWithString:@"https://www.planwallpaper.com/static/images/70e4d6d6108f68cfa6e50a44cbd9e115_large.jpg"]];
    
    // prepare the images to be shown in the slide show
    DownloadingSlideShowImagePreparation *imagePreparation = [[DownloadingSlideShowImagePreparation alloc] initWithImageURLs:urls];
    [imagePreparation prepareImages:^(BOOL success, NSArray<UIImage *> *images, NSError *error) {
        if (success) {
            TestSlideShowImageProvider *imageProvider = [[TestSlideShowImageProvider alloc] initWithImages:images];
            
            self.slideShowController = [[ARSlideShowController alloc] initWithImageProvider:imageProvider containerView:self.view musicController:nil];
            self.slideShowController.repeat   = YES;
            self.slideShowController.delegate = self;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.slideShowController beginSlideShow];
            });
        }
    }];
}


#pragma mark - ARSlideShowControllerDelegate methods

- (void)slideShowControllerDidEnd:(ARSlideShowController *)slideShowController willRepeat:(BOOL)willRepeat
{
    NSLog(@"Slideshow did reach end");
}

@end
