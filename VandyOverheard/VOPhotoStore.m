//
//  VOPhotoStore.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/9/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

#import "VOPhotoStore.h"

@interface VOPhotoStore ()

/**
 * @abstract
 *  Hash of photos by the url string.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *photoHash;

@end

@implementation VOPhotoStore

- (void)photoForUrl:(NSURL *)url block:(PhotoBlock)block {
    
}


@end
