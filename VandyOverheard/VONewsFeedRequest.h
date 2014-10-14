//
//  VOFeedRequest.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/11/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VOFacebookRequestProtocol.h"

@class VONewsFeed;

/**
 * A request that can be passed to indicate
 * the parameters desired for fetching a newsfeed.
 */
@interface VONewsFeedRequest : NSObject <VOFacebookRequestProtocol>

/**
 * @abstract
 *  A block that is executed when the
 *  request has succeeded. This block
 *  will contain an array of VOPost
 *  objects representing the posts
 *  that will go into the newsFeed.
 *  This will also contain an object
 *  representing the request for the
 *  next set of posts in the newsfeed.
 */
@property (nonatomic, copy) void(^successBlock)(NSArray *posts, VONewsFeedRequest *next);

/**
 * @abstract
 *  A block that is executed when the request
 *  has failed.
 */
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

/**
 * @abstract
 *  The parameters that
 *  go into the newsfeed request.
 */
@property (nonatomic, copy) NSDictionary *params;

@end
