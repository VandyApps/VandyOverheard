//
//  VOFeedRequest.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/11/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A request that can be passed to indicate
 * the parameters desired for fetching a newsfeed.
 */
@interface VONewsFeedRequest : NSObject

/**
 * @abstract
 *  The newsfeed offset sent to Facebook.
 */
@property (nonatomic, assign) NSInteger offset;

/**
 * @abstract
 *  The newsfeed limit sent to Facebook. This is the number
 *  of posts that are retrieved.
 */
@property (nonatomic, assign) NSInteger limit;

@end
