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
 *  Designated initializer.
 *
 * @param json The json used to create the VOContent.
 */
- (instancetype)initWithJson:(NSDictionary *)json;

/**
 * @return YES if the content is liked by the
 *  given user, false otherwise.
 */
- (BOOL)isLikedByUser:(VOUser *)user;

@end
