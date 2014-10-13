//
//  VONetworkConstants.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONetworkConstants.h"

NSString *const NetworkConstantId = @"id";

NSString *const NetworkConstantData = @"data";

NSString *const NetworkConstantSummary = @"summary";

NSString *const NetworkConstantCount = @"total_count";

NSString *const NetworkConstantTo = @"to";

NSString *const NetworkConstantFrom = @"from";

NSString *const NetworkConstantFullName = @"name";

NSString *const NetworkConstantContent = @"message";

NSString *const NetworkConstantCreationDate = @"created_time";

NSString *const NetworkConstantLikeList = @"likes";

NSString *const NetworkConstantLikeCount = @"like_count";

NSString *const NetworkConstantReplies = @"comments";

NSString *const NetworkConstantLikedBySelf = @"user_likes";

NSString *const NetworkConstantPicture = @"picture";

NSString *const NetworkConstantPaging = @"paging";

NSString *const NetworkConstantNext = @"next";

NSDate *NSDateFromFacebookDate(id date) {
    static NSString *const format = @"YYYY'-'MM'-'dd'T'HH':'mm':'ss'+0000'";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter dateFromString:date];
}
