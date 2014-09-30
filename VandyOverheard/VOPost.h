//
//  VOPost.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VOContent.h"

/**
 * @abstract
 *  A Facebook Post in the Overheard at
 *  Vanderbilt Group.
 */
@interface VOPost : VOContent

/**
 * @abstract
 *  The replies to the post. This is an array of VOContent
 *  objects.
 */
@property (nonatomic, copy, readonly) NSArray *replies;

/**
 * @abstract
 *  The photos of the post. This post has no photos
 *  if this is nil.
 */
@property (nonatomic, copy, readonly) NSArray *photos;

@end
