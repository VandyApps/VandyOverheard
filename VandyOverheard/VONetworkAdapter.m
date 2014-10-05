//
//  VONetworkAdapter.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONetworkAdapter.h"

#import <FacebookSDK/FacebookSDK.h>

static NSString *const FacebookGroupId = @"2255709804";

@implementation VONetworkAdapter

#pragma mark - API Calls

- (void)loadMainThread:(NetworkResponseBlock)response {
    NSString *const path =
        [NSString stringWithFormat:@"%@/feed?fields=likes.summary(true),"
                                    "message,from,created_time,"
                                    "comments.summary(true)", FacebookGroupId];
    
    void(^handler)(FBRequestConnection *, id, NSError *) =
        ^(FBRequestConnection *connection, id result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                response(result, error);
            });
    };
    
    [FBRequestConnection startWithGraphPath:path
                          completionHandler:handler];
}

@end
