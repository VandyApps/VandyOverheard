//
//  VONetworkAdapter.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONetworkAdapter.h"

#import <FacebookSDK/FacebookSDK.h>

#import "VONetworkConstants.h"

static NSString *const FacebookGroupId = @"2255709804";

@interface VONetworkAdapter ()

/**
 * @abstract
 *  Thepath to the next set of posts to the feed.
 */
@property (nonatomic, copy) NSString *nextPath;

/**
 * @abstract
 *  Get the path to the news feed with the given
 *  limit.
 */
- (NSString *)newsFeedPathWithLimit:(NSInteger)limit;

/**
 * @abstract
 *  Use a raw graph url string to set the nextPath so that
 *  the next path is compatible with graph api calls
 *  in the facebook ios sdk.
 *
 * @param The urlString to convert. Note that this includes
 *  the absolute path ( https://graph.facebook.com/v2.1 ) and
 *  has all the character url encoded.
 */
- (NSString *)pathFromRawGraphUrlPath:(NSString *)urlPath;

@end

@implementation VONetworkAdapter

#pragma mark - Paths

- (NSString *)pathFromRawGraphUrlPath:(NSString *)urlPath {
    // Assume path is prepended with the string
    // ( https://graph.facebook.com/v2.1 )
    
    NSString *path = [[urlPath substringFromIndex:31] stringByRemovingPercentEncoding];
    return path;
}


- (NSString *)newsFeedPathWithLimit:(NSInteger)limit {
    static NSString *const pathTemplate =
        @"%@/feed?fields=likes.summary(true),"
         "message,from,created_time,comments.summary(true),"
         "picture&limit=%li";
    
    return [NSString stringWithFormat:pathTemplate, FacebookGroupId, limit];
}


#pragma mark - API Calls

- (void)loadThreadWithLimit:(NSInteger)limit
                   response:(NetworkResponseBlock)response {
    
    NSString *const path = [self newsFeedPathWithLimit:limit];
    
    __weak VONetworkAdapter *weakSelf = self;
    void(^handler)(FBRequestConnection *, id, NSError *) =
        ^(FBRequestConnection *connection, id result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                    weakSelf.nextPath =
                        [weakSelf pathFromRawGraphUrlPath:result[NetworkConstantPaging][NetworkConstantNext]];
                }
                response(result, error);
            });
    };
    
    [FBRequestConnection startWithGraphPath:path
                          completionHandler:handler];
}


- (void)loadThreadForNextPage:(NetworkResponseBlock)response {
    __weak VONetworkAdapter *weakSelf = self;
    void(^handler)(FBRequestConnection *, id, NSError *) =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                weakSelf.nextPath =
                    [weakSelf pathFromRawGraphUrlPath:result[NetworkConstantPaging][NetworkConstantNext]];
            }
            response(result, error);
        });
    };
    
    [FBRequestConnection startWithGraphPath:self.nextPath
                          completionHandler:handler];
}


@end
