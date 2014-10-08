//
//  VOContent.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VOUser;

/**
 * @abstract
 *  A piece of content that is posted on Facebook.
 */
@interface VOContent : NSObject

/**
 * @abstract
 */
@property (nonatomic, copy, readonly) NSString *facebookId;

/**
 * @abstract The author of the content.
 */
@property (nonatomic, strong, readonly) VOUser *author;

/**
 * @abstract The date the post was created.
 */
@property (nonatomic, strong, readonly) NSDate *creationDate;

/**
 * @abstract The number of likes for the content.
 */
@property (nonatomic, assign, readonly) NSInteger likeCount;

/**
 * @abstract The body of the content.
 */
@property (nonatomic, strong, readonly) NSString *body;

/**
 * @abstract
 *  YES if the post is liked by the current user.
 */
@property (nonatomic, assign, readonly) BOOL isLiked;

/**
 * @abstract
 *  Designated initializer.
 *
 * @param json The json used to create the VOContent.
 */
- (instancetype)initWithJson:(NSDictionary *)json;

@end
