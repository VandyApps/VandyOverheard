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
#import "VOFacebookRequestProtocol.h"


@interface VONetworkAdapter ()

/**
 * @abstract
 *  Thepath to the next set of posts to the feed.
 */
@property (nonatomic, copy) NSString *nextPath;

@end

@implementation VONetworkAdapter

#pragma mark - Path

- (NSString *)pathForRequest:(id<VOFacebookRequestProtocol>)request {
    // Encode parameters
    NSMutableString *encodedParams = [[NSMutableString alloc] init];
    
    NSArray *keys = [[request params] allKeys];
    for (NSInteger i = 0; i < [keys count]; ++i) {
        if (i == 0) {
            [encodedParams appendString:@"?"];
        }
        else {
            [encodedParams appendString:@"&"];
        }
        [encodedParams appendFormat:@"%@=%@", keys[i], [[request params] objectForKey:keys[i]]];
    }
    
    return [[request path] stringByAppendingString:encodedParams];
}


#pragma mark - API Calls

- (void)processRequest:(id<VOFacebookRequestProtocol>)request {
    NSString *path = [self pathForRequest:request];
    
    void(^handler)(FBRequestConnection *, id, NSError *) =
        ^(FBRequestConnection *connection, id result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    [request failureWithError:error];
                }
                else {
                    [request successWithJson:result];
                }
            });
        };
    
    [FBRequestConnection startWithGraphPath:path
                          completionHandler:handler];
}


@end
