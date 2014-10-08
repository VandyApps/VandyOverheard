//
//  VOFeedStore.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOFeedStore.h"

#import "VOPost.h"

@interface VOFeedStore ()

/**
 * @abstract
 *  An array of all the posts.
 */
@property (nonatomic, strong) NSMutableArray *posts;

@end

@implementation VOFeedStore

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


- (VOPost *)postAtIndex:(NSInteger)index {
    return [self.posts objectAtIndex:index];
}


@end
