//
//  VOProfilePictureStore.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <Foundation/Foundation.h>

@class VONewsFeed;
@class VOUser;

@interface VOProfilePictureStore : NSObject

/**
 * @return The profile picture associated with the
 *  given user.
 */
- (FBProfilePictureView *)profilePictureForUser:(VOUser *)user;

/**
 * @abstract
 *  Begin downloading the profile pictures associated
 *  with the newsfeed.
 *
 * @param feed The newsfeed to download the profile
 *  pictures for.
 */
- (void)downloadProfilePicturesForNewsFeed:(VONewsFeed *)feed;

/**
 * @abstract
 *  Begin downloading the profile picture for the given user.
 *  This is an optimization for faster profile picture loading.
 *
 * @discussion This method should always be executed on the main
 *  thread.  If the profile picture for the given user is already
 *  downloaded, then this will refresh the profile picture with
 *  a new download.
 */
- (void)downloadProfilePictureForUser:(VOUser *)user;

@end
