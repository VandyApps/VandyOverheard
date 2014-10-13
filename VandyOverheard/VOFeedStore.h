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

typedef void(^VONewsFeedBlock)(VONewsFeed *newsFeed, NSInteger delta);

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
 *
 * @param posts An array of VOPost objects
 *  to add to the FeedStore.
 *
 * @return The delta, or the difference
 *  between the number of cells that
 *  were in the posts before and after
 *  this call. Note that the number of cells
 *  added is not necessarily the same
 *  as the number of cells in the posts
 *  array, since some posts may be overwritten.
 */
- (NSInteger)addPosts:(NSArray *)posts;

/**
 * @abstract
 *  Fetch the news feed ansynchronously.
 *
 * @param request The request with the desired parameters and
 *  configuration for the newsfeed.
 *
 * @param block The callback block that gives the newsfeed
 *  that was fetched.
 */
- (void)fetchNewsFeedWithRequest:(VONewsFeedRequest *)request
                           block:(VONewsFeedBlock)block;

/**
 * @abstract
 *  Fetch the news feed associated with the next
 *  page of available content.
 *
 * @param block The block that is called asynchonously
 *  with the next set of content.
 */
- (void)fetchNewsFeedForNextPage:(VONewsFeedBlock)block;

@end
