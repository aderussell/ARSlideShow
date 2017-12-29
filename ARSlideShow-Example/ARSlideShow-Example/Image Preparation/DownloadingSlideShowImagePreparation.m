//
//  DownloadingSlideShowImagePreparation.m
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import "DownloadingSlideShowImagePreparation.h"

@interface DownloadingSlideShowImagePreparation ()
@property (nonatomic, strong, nullable) NSArray<UIImage *> *loadedImages;
@end

@implementation DownloadingSlideShowImagePreparation

- (instancetype)initWithImageURLs:(NSArray<NSURL *> *)urls
{
    if (self = [super init]) {
        _urls = urls;
    }
    return self;
}

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler
{
    //@"https://www.planwallpaper.com/static/images/computer-desktop-wallpapers-3d.jpg";
    //@"https://www.planwallpaper.com/static/images/Desktop-Wallpaper-HD7.jpg";
    //@"https://www.planwallpaper.com/static/images/desktop-wallpaper-green.jpg";
    //@"https://www.planwallpaper.com/static/images/70e4d6d6108f68cfa6e50a44cbd9e115_large.jpg";
}

- (NSArray<UIImage *> *)images
{
    return [self.loadedImages copy] ?: @[];
}

@end
