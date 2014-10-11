//
//  VONewsFeed.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeed.h"

#import "VONetworkAdapter.h"
#import "VONetworkConstants.h"
#import "VOPost.h"

@implementation VONewsFeed

#pragma mark - Initialization

- (instancetype)initWithPosts:(NSArray *)posts {
    self = [super init];
    if (self) {
        _posts = posts;
    }
    return self;
}

@end
