//
//  VOPost.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOPost.h"

#import "VONetworkConstants.h"

@implementation VOPost

#pragma mark - Initialization

- (instancetype)initWithJson:(NSDictionary *)json {
    self = [super initWithJson:json];
    if (self) {
        if (json[NetworkConstantReplies]) {
            _replyCount =
                [json[NetworkConstantReplies][NetworkConstantSummary][NetworkConstantCount] integerValue];
        }
    }
    return self;
}

@end
