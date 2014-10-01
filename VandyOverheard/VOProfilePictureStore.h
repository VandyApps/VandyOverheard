//
//  VOProfilePictureStore.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <Foundation/Foundation.h>

@class VOUser;

@interface VOProfilePictureStore : NSObject

/**
 * @abstract
 *  Get the singleton instance of the profile
 *  picture store.
 */
+ (instancetype)sharedInstance;

/**
 * @return The profile picture associated with the
 *  given user.
 */
- (FBProfilePictureView *)profilePictureForUser:(VOUser *)user;

@end
