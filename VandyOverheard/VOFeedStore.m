//
//  VOFeedStore.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOFeedStore.h"

#import "VONetworkAdapter.h"
#import "VONetworkConstants.h"
#import "VONewsFeedRequest.h"
#import "VOPost.h"

@interface VOFeedStore ()

/**
 * @abstract
 *  The success block that should be called during any
 *  successful network call.
 */
@property (nonatomic, copy) void(^successBlock)(NSArray *posts, VONewsFeedRequest *next);

/**
 * @abstract
 *  The failure block that should be called during any
 *  failed network call.
 */
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

/**
 * @abstract
 *  The network adapter that manages network
 *  calls.
 */
@property (nonatomic, strong) VONetworkAdapter *network;

/**
 * @abstract
 *  An array of all the posts in a mutable
 *  array for convenient updates.
 */
@property (nonatomic, strong) NSMutableArray *mPosts;

/**
 * @abstract
 *  The request for the next page of
 *  posts. If no requests have been made
 *  yet, this will be nil.
 */
@property (nonatomic, strong) VONewsFeedRequest *next;

@end

static NSInteger NewsFeedLimit = 30;

@implementation VOFeedStore

#pragma mark - Accessors

- (NSInteger)networkLimit {
    return NewsFeedLimit;
}


- (NSArray *)posts {
    return [self.mPosts copy];
}


- (NSInteger)count {
    return self.posts.count;
}


- (void (^)(NSArray *, VONewsFeedRequest *))successBlock {
    if (_successBlock == nil) {
        __weak VOFeedStore *weakSelf = self;
        _successBlock = ^(NSArray *posts, VONewsFeedRequest *next) {
            NSInteger delta = [weakSelf addPosts:posts];
            weakSelf.next = next;
            if (weakSelf.delegate) {
                [weakSelf.delegate feedStore:weakSelf didUpdateWithDelta:delta];
            }
        };
    }
    return _successBlock;
}


- (void (^)(NSError *))failureBlock {
    if (_failureBlock == nil) {
        __weak VOFeedStore *weakSelf = self;
        _failureBlock = ^(NSError *error) {
            if (weakSelf.delegate) {
                [weakSelf.delegate feedStore:weakSelf failedWithError:error];
            }
        };
    }
    return _failureBlock;
}


#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _network = [[VONetworkAdapter alloc] init];
        _mPosts = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - Add

- (NSInteger)addPosts:(NSArray *)posts {
    // Update the given array with the new posts.
    NSInteger oldCount = [self.posts count];
    
    [self.mPosts removeObjectsInArray:posts];
    [self.mPosts addObjectsFromArray:posts];
    
    // Sort them.
    [self.mPosts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        VOPost *post1 = obj1;
        VOPost *post2 = obj2;
        // Reverse chonological ordering.
        return [post2.creationDate compare:post1.creationDate];
    }];
    
    NSInteger newCount = [self.posts count];
    return newCount - oldCount;
}


#pragma mark - Network

- (void)fetchFirstPage {
    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    request.params = @{
                      @"fields": @"likes.summary(true),"
                                  "message,from,created_time,"
                                  "comments.summary(true),"
                                  "picture",
                      @"limit": @(self.networkLimit)
                     };
    
    request.successBlock = self.successBlock;
    request.failureBlock = self.failureBlock;
    [self.network processRequest:request];
}


- (void)fetchNextPage {
    // TODO: Throw an exception if fetch first page
    // was not called at least once. Can check this
    // by checking if next property is nil.

    self.next.successBlock = self.successBlock;
    [self.network processRequest:self.next];
}


@end
