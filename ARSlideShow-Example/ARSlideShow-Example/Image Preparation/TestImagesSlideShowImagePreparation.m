//
//  TestImagesSlideShowImagePreparation.m
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import "TestImagesSlideShowImagePreparation.h"

@interface TestImagesSlideShowImagePreparation ()
@property (nonatomic, strong, nullable) NSArray<UIImage *> *loadedImages;
@end

@implementation TestImagesSlideShowImagePreparation

- (BOOL)isPrepared
{
    return (self.images.count > 0);
}

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler
{
    self.loadedImages = @[ [UIImage imageNamed:@"Abstract"],
                           [UIImage imageNamed:@"Abstract Shapes"],
                           [UIImage imageNamed:@"Antelope Canyon"],
                           [UIImage imageNamed:@"Bahamas Aerial"],
                           [UIImage imageNamed:@"Brushes"],
                           [UIImage imageNamed:@"Color Burst 1"],
                           [UIImage imageNamed:@"Earth and Moon"],
                           [UIImage imageNamed:@"Hawaiian Print"],
                           [UIImage imageNamed:@"Pink Lotus Flower"],
                           [UIImage imageNamed:@"Zebras"] ];
}

- (NSArray<UIImage *> *)images
{
    return [self.loadedImages copy] ?: @[];
}

@end
