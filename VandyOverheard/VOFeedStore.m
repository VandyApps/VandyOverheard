//
//  VOFeedStore.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOFeedStore.h"

#import "VONetworkAdapter.h"
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

@end

@implementation VOFeedStore

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _network = [[VONetworkAdapter alloc] init];
    }
    return self;
}

#pragma mark - Accessors

- (NSInteger)count {
    return self.posts.count;
}

#pragma mark - Add

- (void)addPosts:(NSArray *)posts {
    // Update the given array with the new posts.
    [self.posts removeObjectsInArray:posts];
    [self.posts addObjectsFromArray:posts];
    
    // Sort them.
    [self.posts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        VOPost *post1 = obj1;
        VOPost *post2 = obj2;
        // Reverse chonological ordering.
        return [post2.creationDate compare:post1.creationDate];
    }];
}


#pragma mark - Fetch

- (void)fetchNewsFeedWithRequest:(VONewsFeedRequest *)request block:(NewsFeedBlock)block {
    
    void(^requestBlock)(id, NSError *) = ^ (id result, NSError *error) {
        if (error) {
#warning Handle Error
            NSLog(@"Error: %@", error);
        }
        else {
            block([[VONewsFeed alloc] initWithJson:result]);
        }
    };
    [self.network loadThreadWithOffset:request.offset
                                 limit:request.limit
                              response:requestBlock];

}


@end
