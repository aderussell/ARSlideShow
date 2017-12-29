//
//  ARSlideShowMusicController.m
//
//  Created by Adrian Russell on 28/12/2017.
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

#import "ARSlideShowMusicController.h"

@implementation ARSlideShowMusicController

- (instancetype)initWithMediaQuery:(MPMediaQuery *)mediaQuery
{
    if (self = [super init]) {
        _musicPlayerController = [MPMusicPlayerController applicationQueuePlayer];
        [_musicPlayerController setQueueWithQuery:mediaQuery];
        [self prepareMusic];
    }
    return self;
}

- (instancetype)initWithMediaItem:(MPMediaItem *)mediaItem
{
    return [self initWithMediaItemCollection:[[MPMediaItemCollection alloc] initWithItems:@[mediaItem]]];
}

- (instancetype)initWithMediaItemCollection:(MPMediaItemCollection *)mediaItemCollection
{
    if (self = [super init]) {
        _musicPlayerController = [MPMusicPlayerController applicationQueuePlayer];
        [_musicPlayerController setQueueWithItemCollection:mediaItemCollection];
        [self prepareMusic];
    }
    return self;
}



- (void)prepareMusic
{
    self.musicPlayerController.repeatMode = MPRepeatTypeAll;
    [self.musicPlayerController prepareToPlay];
}

- (void)startMusic
{
    [self.musicPlayerController play];
}

- (void)endMusic
{
    [self.musicPlayerController stop];
}


@end
