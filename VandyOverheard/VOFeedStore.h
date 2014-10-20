//
//  VOFeedStore.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VOFeedStoreDelegate.h"

@class VOPost;
@class VONewsFeedRequest;

// TODO: Create new enumeration object to separate
// responsibilities of access and collect.
typedef void(^VONewsFeedBlock)(NSInteger delta);

/**
 * @abstract
 *  A Store containing all the cached posts from the newsfeed.
 *  Keeps the posts sorted in reverse-chronological order.
 */
@interface VOFeedStore : NSObject

/**
 * @abstract
 *  The limit on the number of posts fetched
 *  every time a network call is made.
 */
@property (nonatomic, assign, readonly) NSInteger networkLimit;

/**
 * @abstract
 *  The delegate for the NewsFeedStore.
 */
@property (nonatomic, weak) id<VOFeedStoreDelegate> delegate;

/**
 * @abstract
 *  The number of posts in the store.
 */
@property (nonatomic, assign, readonly) NSInteger count;

/**
 * @abstract
 *  An array of posts related to this
 *  feed.
 */
@property (nonatomic, copy, readonly) NSArray *posts;

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
 *  Get the first set of posts from the news
 *  feed. The delegate is called when the newsfeed
 *  has been fetched.
 *
 * @discussion
 *  This method should only be called on the
 *  main thread.
 */
// TODO: Modify this method to throw some error
// if trying to fetch while a page is in the
// process of already being fetched.
- (void)fetchFirstPage;

/**
 * @abstract
 *  Get the next set of posts from the newsfeed.
 *  fetchFirstPage must be called at least once
 *  before calling this method. The delegate is called
 *  when the page has been fetched.
 *
 * @discussion
 *  This method should only be called on the main
 *  thread.
 */
// TODO: Modify this method to throw some error
// if trying to fetch while a page is in the
// process of already being fetched.
- (void)fetchNextPage;

@end
