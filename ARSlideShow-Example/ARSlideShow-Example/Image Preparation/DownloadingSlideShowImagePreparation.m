//
//  DownloadingSlideShowImagePreparation.m
//  SlideShow
//
//  Created by Adrian Russell on 11/12/2017.
//  Copyright © 2017 Adrian Russell. All rights reserved.
//

#import "DownloadingSlideShowImagePreparation.h"

@interface DownloadingSlideShowImagePreparation ()
@property (nonatomic, strong, nonnull) NSURLSession *urlSession;
@property (nonatomic, strong, nullable) NSArray<UIImage *> *loadedImages;
@property (nonatomic, strong, nullable) NSMutableArray *downloadingImages;
@property (nonatomic, strong, nullable) NSArray<NSURLSessionTask *> *downloadTasks;
@end

@implementation DownloadingSlideShowImagePreparation

- (instancetype)initWithImageURLs:(NSArray<NSURL *> *)urls
{
    if (self = [super init]) {
        _urls = urls;
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)prepareImages:(void(^)(BOOL success, NSArray<UIImage *> *images, NSError *error))completionHandler
{
    self.downloadingImages = [NSMutableArray arrayWithCapacity:self.urls.count];
    for (NSUInteger i = 0; i < self.urls.count; i++) {
        [self.downloadingImages addObject:[NSNull null]];
    }
    
    NSMutableArray<NSURLSessionTask *> *tasks = [NSMutableArray arrayWithCapacity:self.urls.count];
    
    for (NSURL *url in self.urls) {
        NSURLSessionDataTask *task = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSInteger index = [self.urls indexOfObject:url];
            if (index != NSNotFound) {
                
                // create the image from the response data
                if (data) {
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    if (image) {
                        self.downloadingImages[index] = image;
                    }
                }
                
                // check if the have all completed
                BOOL completed = YES;
                for (NSURLSessionTask *task in self.downloadTasks) {
                    if (task.state != NSURLSessionTaskStateCompleted) {
                        completed = NO;
                    }
                }
                
                // if completed set the images array and call the completion handler
                if (completed) {
                    self.loadedImages = [self.downloadingImages filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != %@", [NSNull null]]];
                    if (completionHandler) {
                        completionHandler(YES, self.loadedImages, nil);
                    }
                }
            }
        }];
        [tasks addObject:task];
    }
    
    self.downloadTasks = [tasks copy];
    
    // start the tasks
    for (NSURLSessionTask *task in self.downloadTasks) {
        [task resume];
    }
}

- (NSArray<UIImage *> *)images
{
    return [self.loadedImages copy] ?: @[];
}

@end
