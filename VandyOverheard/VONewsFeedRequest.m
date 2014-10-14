//
//  VOFeedRequest.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/11/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedRequest.h"

#import "VONetworkConstants.h"
#import "VOPost.h"

// TODO: This should automatically be
// preprended to any requests. Should be in
// the VONetworkAdapter
static NSString *const FacebookGroupId = @"2255709804";

@interface VONewsFeedRequest ()

/**
 * @abstract
 *  Parse the json related to the post
 *  data.
 */
+ (NSArray *)parseJson:(id)json;

/**
 * @abstract
 *  Create a request from the absolute path
 *  to facebook.
 */
+ (VONewsFeedRequest *)requestFromAbsolutePath:(NSString *)path;

@end


@implementation VONewsFeedRequest

#pragma mark - Static Methods

+ (NSArray *)parseJson:(id)json {
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for (id postJson in json[NetworkConstantData]) {
        VOPost *post = [[VOPost alloc] initWithJson:postJson];
        [posts addObject:post];
    }
    
    return [posts copy];
}


+ (VONewsFeedRequest *)requestFromAbsolutePath:(NSString *)path {
    // TODO: This logic of pulling out parameters should exist in
    // VONetworkAdapter

    // TODO: Add regex to confirm path is in
    // the correct form.
    
    // TODO: Make this less fragile.
    
    // Assume path is prepended with the string
    // ( https://graph.facebook.com/v2.1/group-id/feed? )
    
    NSInteger groupIdLength = [FacebookGroupId length];
    NSString *paramPath = [[path substringFromIndex:37+groupIdLength] stringByRemovingPercentEncoding];
    
    NSArray *keyValuePairs = [paramPath componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    for (NSString *pair in keyValuePairs) {
        NSArray *paramPair = [pair componentsSeparatedByString:@"="];
        // Assume param has length 2, key/value pair.
        [params setObject:paramPair[1] forKey:paramPair[0]];
    }

    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    request.params = params;

    return request;
}


#pragma mark - VONetworkRequestProtocol Methods

- (NSString *)path {
    return [FacebookGroupId stringByAppendingString:@"/feed"];
}
             /*@"fields": @"likes.summary(true),"
                         "message,from,created_time,"
                         "comments.summary(true),"
                         "picture",*/



- (void)successWithJson:(id)json {
    // extract any json related to the
    // request for the next newsFeed.
    
    NSString *nextPath = json[NetworkConstantPaging][NetworkConstantNext];
    
    self.successBlock([VONewsFeedRequest parseJson:json],
                      [VONewsFeedRequest requestFromAbsolutePath:nextPath]);
}


- (void)failureWithError:(NSError *)error {
    self.failureBlock(error);
}


@end
