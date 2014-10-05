//
//  VONetworkConstants.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const NetworkConstantId;

extern NSString *const NetworkConstantData;

extern NSString *const NetworkConstantSummary;

extern NSString *const NetworkConstantCount;

extern NSString *const NetworkConstantTo;

extern NSString *const NetworkConstantFrom;

extern NSString *const NetworkConstantFullName;

extern NSString *const NetworkConstantContent;

extern NSString *const NetworkConstantCreationDate;

extern NSString *const NetworkConstantLikeList;

extern NSString *const NetworkConstantReplies;

extern NSString *const NetworkConstantLikedBySelf;

extern NSString *const NetworkConstantLikeCount;

/**
 * @abstract
 *  Convert a facebook date to an actual date.
 *
 * @return The date equivalent to the facebook
 *  date.
 */
NSDate *NSDateFromFacebookDate(id date);