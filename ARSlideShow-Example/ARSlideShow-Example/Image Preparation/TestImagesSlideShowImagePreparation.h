//
//  TestImagesSlideShowImagePreparation.h
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideShowImagePreparation.h"

/**
 *  Loads all the test images from the asset catalogue to display.
 */
@interface TestImagesSlideShowImagePreparation : NSObject <SlideShowImagePreparation>

@property (readonly, getter=isPrepared) BOOL prepared;

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler;

- (NSArray<UIImage *> *)images;

@end
