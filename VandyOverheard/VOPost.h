//
//  VOPost.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VOContent.h"

/**
 * @abstract
 *  A Facebook Post in the Overheard at
 *  Vanderbilt Group.
 */
@interface VOPost : VOContent

/**
 * @abstract
 *  The number of replies to this post.
 */
@property (nonatomic, assign, readonly) NSInteger replyCount;

/**
 * @abstract
 *  The photos of the post. This post has no photos
 *  if this is nil.
 */
@property (nonatomic, copy, readonly) NSArray *photos;

/**
 * @abstract
 *  The picture for the post, if there is one. If this
 *  post has no picture, this will be nil.
 */
@property (nonatomic, strong, readonly) UIImage *picture;

@end
