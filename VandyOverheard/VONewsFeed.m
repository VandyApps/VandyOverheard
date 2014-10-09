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

@interface VONewsFeed ()

/**
 * @abstract
 *  Reset the posts for the newsfeed using the results that
 *  come back after parsing the results.
 */
- (void)parse:(id)result;

@end

@implementation VONewsFeed

#pragma mark - Initialization

- (instancetype)initWithJson:(id)json {
    self = [super init];
    if (self) {
        [self parse:json];
    }
    return self;
}


#pragma mark - Parse

- (void)parse:(id)json {
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for (id postJson in json[NetworkConstantData]) {
        VOPost *post = [[VOPost alloc] initWithJson:postJson];
        [posts addObject:post];
    }
    
    _posts = [posts copy];
}


@end
