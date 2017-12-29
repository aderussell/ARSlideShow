//
//  DownloadingSlideShowImagePreparation.h
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideShowImagePreparation.h"

@interface DownloadingSlideShowImagePreparation : NSObject <SlideShowImagePreparation>

@property (readonly, getter=isPrepared) BOOL prepared;

@property (readonly) NSArray<NSURL *> *urls;

- (instancetype)initWithImageURLs:(NSArray<NSURL *> *)urls;

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler;

- (NSArray<UIImage *> *)images;

@end
