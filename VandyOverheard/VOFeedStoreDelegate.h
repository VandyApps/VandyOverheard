//
//  VOFeedStoreDelegate.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/14/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

@class VOFeedStore;

#ifndef VandyOverheard_VOFeedStoreDelegate_h
#define VandyOverheard_VOFeedStoreDelegate_h

@protocol VOFeedStoreDelegate <NSObject>

/**
 * @abstract
 *  Notifies when a feed store has successfully
 *  updated after making a network call.
 *  This delegate gives back a delta value, which
 *  is the number of posts that have been added to the feed store
 *  during the update. This will be a negative number if posts have
 *  been removed.
 */
- (void)feedStore:(VOFeedStore *)store didUpdateWithDelta:(NSInteger)delta;

/**
 * @abstract
 *  Notifies when a feed store has failed
 *  during a network call.
 */
- (void)feedStore:(VOFeedStore *)store failedWithError:(NSError *)error;

@end

#endif
