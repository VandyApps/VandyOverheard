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
#import "VONewsFeed.h"
#import "VONewsFeedRequest.h"
#import "VOPost.h"

@interface VOFeedStore ()

/**
 * @abstract
 *  The network adapter that manages network
 *  calls.
 */
@property (nonatomic, strong) VONetworkAdapter *network;

/**
 * @abstract
 *  An array of all the posts.
 */
@property (nonatomic, strong) NSMutableArray *posts;

/**
 * @abstract
 *  Parse a json set of posts to an array
 *  of VOPosts.
 */
- (NSArray *)parsePosts:(id)json;

@end

@implementation VOFeedStore

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _network = [[VONetworkAdapter alloc] init];
        _posts = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Accessors

- (NSInteger)count {
    return self.posts.count;
}

#pragma mark - Add

- (NSInteger)addPosts:(NSArray *)posts {
    // Update the given array with the new posts.
    NSInteger oldCount = [self.posts count];
    
    [self.posts removeObjectsInArray:posts];
    [self.posts addObjectsFromArray:posts];
    
    // Sort them.
    [self.posts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        VOPost *post1 = obj1;
        VOPost *post2 = obj2;
        // Reverse chonological ordering.
        return [post2.creationDate compare:post1.creationDate];
    }];
    
    NSInteger newCount = [self.posts count];
    return newCount - oldCount;
}


#pragma mark - Fetch

- (void)fetchNewsFeedWithRequest:(VONewsFeedRequest *)request block:(NewsFeedBlock)block {

    __weak VOFeedStore *weakSelf = self;
    void(^requestBlock)(id, NSError *) = ^ (id result, NSError *error) {
        if (error) {
#warning Handle Error
            NSLog(@"Error: %@", error);
        }
        else {
            NSInteger delta = [weakSelf addPosts:[self parsePosts:result]];
            VONewsFeed *feed = [[VONewsFeed alloc] initWithPosts:self.posts];
            block(feed, delta);
        }
    };
    [self.network loadThreadWithOffset:request.offset
                                 limit:request.limit
                              response:requestBlock];

}


#pragma mark - Parse

- (NSArray *)parsePosts:(id)json {
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for (id postJson in json[NetworkConstantData]) {
        VOPost *post = [[VOPost alloc] initWithJson:postJson];
        [posts addObject:post];
    }
    
    return [posts copy];
}


@end
