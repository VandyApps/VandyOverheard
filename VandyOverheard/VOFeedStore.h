//
//  VOFeedStore.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VONewsFeed;
@class VOPost;
@class VONewsFeedRequest;

typedef void(^NewsFeedBlock)(VONewsFeed *newsFeed);

/**
 * @abstract
 *  A Store containing all the cached posts from the newsfeed.
 *  Keeps the posts sorted in reverse-chronological order.
 */
@interface VOFeedStore : NSObject

/**
 * @abstract
 *  The number of posts in the store.
 */
@property (nonatomic, assign, readonly) NSInteger count;

/**
 * @abstract
 *  Add the posts to the feed store.
 *  This will overwrite any posts that
 *  already exist in the store.
 */
- (void)addPosts:(NSArray *)posts;

/**
 * @abstract
 *  Fetch the news fee ansynchronously.
 *
 * @param request The request with the desired parameters and
 *  configuration for the newsfeed.
 *
 * @param block The callback block that gives the newsfeed
 *  that was fetched.
 */
- (void)fetchNewsFeedWithRequest:(VONewsFeedRequest *)request
                           block:(NewsFeedBlock)block;

@end
