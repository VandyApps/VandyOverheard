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

@interface VONetworkAdapter ()

/**
 * @abstract
 *  Get the path to the news feed with the given
 *  offset and limit.
 */
- (NSString *)newsFeedPathWithOffset:(NSInteger)offset limit:(NSInteger)limit;

@end

@implementation VONetworkAdapter

#pragma mark - Path

- (NSString *)newsFeedPathWithOffset:(NSInteger)offset limit:(NSInteger)limit {
    static NSString *const pathTemplate =
        @"%@/feed?fields=likes.summary(true),"
         "message,from,created_time,comments.summary(true),"
         "picture&limit=%li&offset=%li";
    
    return [NSString stringWithFormat:pathTemplate, FacebookGroupId, limit, offset];
}


#pragma mark - API Calls

- (void)loadThreadWithOffset:(NSInteger)offset
                       limit:(NSInteger)limit
                    response:(NetworkResponseBlock)response {
    NSString *const path = [self newsFeedPathWithOffset:offset limit:limit];
    
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
