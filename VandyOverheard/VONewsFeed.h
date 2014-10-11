//
//  VONewsFeed.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VONewsFeed : NSObject

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
 *  Designated initializer.
 *
 * @param posts An array of VOPost object to add
 *  to the newsfeed.
 */
- (instancetype)initWithPosts:(NSArray *)posts;

@end
