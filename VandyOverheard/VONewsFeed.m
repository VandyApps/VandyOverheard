//
//  VONewsFeed.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeed.h"

#import "VONetworkAdapter.h"
#import "VOPost.h"

@interface VONewsFeed ()

#pragma mark - Private Properties

/**
 * @abstract
 *  The newtwork adapter used to make network requests.
 */
@property (nonatomic, strong) VONetworkAdapter *networkAdapter;

/**
 * @abstract
 *  Reset the posts for the newsfeed using the results that
 *  come back after parsing the results.
 */
- (void)parseResult:(id)result;

@end

@implementation VONewsFeed

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkAdapter = [[VONetworkAdapter alloc] init];
    }
    return self;
}


#pragma mark - Refresh

- (void)refresh {
    [self.networkAdapter loadMainThread:^(id result, NSError *error) {
        if (error) {
#warning Handle error here!
        }
        // Load the data here.
        [self parseResult:result];
        if (self.delegate) {
            [self.delegate newsFeedDidRefresh:self];
        }
    }];
}


#pragma mark - Parse

- (void)parseResult:(id)result {
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for (id postJson in result[@"data"]) {
        VOPost *post = [[VOPost alloc] initWithJson:postJson];
        [posts addObject:post];
    }
    
    _posts = [posts copy];
}


@end
