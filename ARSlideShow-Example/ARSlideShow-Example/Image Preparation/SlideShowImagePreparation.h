//
//  SlideShowImagePreparation.h
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideShowImagePreparation <NSObject>

@property (readonly, getter=isPrepared) BOOL prepared;

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler;

- (NSArray<UIImage *> *)images;

@end
