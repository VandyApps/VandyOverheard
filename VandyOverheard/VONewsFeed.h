//
//  VONewsFeed.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VONewsFeedDelegate.h"

@interface VONewsFeed : NSObject

/**
 * @abstract
 *  The delegate responsible for handling
 *  any asynchonous callbacks. This may be
 *  nil.
 */
@property (nonatomic, weak) id<VONewsFeedDelegate> delegate;

/**
 * @abstract
 *  The posts that are currently loaded from
 *  the Overheard at Vanderbilt thread. These
 *  posts will always be in reverse-chonological
 *  order.
 */
@property (nonatomic, copy, readonly) NSArray *posts;

/**
 * @abstract
 *  Refresh the news feed. This method will
 *  cause the news feed to be fetched asynchonously.
 *  Once the newsfeed has been fetched, the delegate
 *  will be notified.
 */
- (void)refresh;

@end
