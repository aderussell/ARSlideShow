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
#import "TestSlideShowImageProvider.h"

@interface SlideShowViewController ()
@property (nonatomic, strong, nullable) ARSlideShowController *slideShowController;

@end

@implementation SlideShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // prepare the images to be shown in the slide show
    TestImagesSlideShowImagePreparation *imagePreparation = [[TestImagesSlideShowImagePreparation alloc] init];
    [imagePreparation prepareImages:nil];
    
    TestSlideShowImageProvider *imageProvider = [[TestSlideShowImageProvider alloc] initWithImages:imagePreparation.images];
    
    self.slideShowController = [[ARSlideShowController alloc] initWithImageProvider:imageProvider containerView:self.view musicController:nil];
    self.slideShowController.repeat = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.slideShowController beginSlideShow];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
