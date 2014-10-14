//
//  VONetworkAdapter.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VOFacebookRequestProtocol.h"

typedef void(^NetworkResponseBlock)(id result, NSError *error);

@interface VONetworkAdapter : NSObject

/**
 * @abstract
 *  Convert the request into a path that
 *  can be used to make a network call for facebook.
 */
- (NSString *)pathForRequest:(id<VOFacebookRequestProtocol>)request;

/**
 * @abstract
 *  Make a network request and process the result.
 */
- (void)processRequest:(id<VOFacebookRequestProtocol>)request;

@end
