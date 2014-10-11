//
//  VONetworkAdapter.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkResponseBlock)(id result, NSError *error);

@interface VONetworkAdapter : NSObject

/**
 * @abstract
 *  Load the main thread from the network.
 *
 * @param offset The offset of the pages for pagination
 *  purposes.
 *
 * @param limit The limit of the pages for pagination
 *  purposes.
 */
// - (void)loadMainThreadWithOffset:(NSInteger)offset limit:(NSInteger)limit;

/**
 * @abstract
 *  Loads the thread of the newsfeed. The results
 *  will be passed to the reponse block parameter.
 *  This method will be called asynchronously but
 *  the response block will be executed on the
 *  main thread.
 *
 * @param The offset to get from the NewsFeed.
 *
 * @param The limit to the number of posts that are
 *  fetched from the newsfeed.
 */
- (void)loadThreadWithOffset:(NSInteger)offset
                        limit:(NSInteger)limit
                    response:(NetworkResponseBlock)response;

@end
