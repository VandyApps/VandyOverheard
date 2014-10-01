//
//  VOProfilePictureStore.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOProfilePictureStore.h"

#import "VOUser.h"

@interface VOProfilePictureStore ()

/**
 * @abstract
 *  A hash table for looking up profile pictures
 *  based on user id's.
 */
@property (nonatomic, strong) NSMutableDictionary *pictureHash;

@end


@implementation VOProfilePictureStore

#pragma mark - Static Methods

+ (instancetype)sharedInstance {
    static dispatch_once_t dispatch_token;
    static VOProfilePictureStore *instance = nil;
    
    dispatch_once(&dispatch_token, ^{
        instance = [[VOProfilePictureStore alloc] init];
    });
    return instance;
}


+ (CGFloat)pictureDimensions {
    return 3.0;
}


#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        _pictureHash = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (FBProfilePictureView *)profilePictureForUser:(VOUser *)user {
    FBProfilePictureView *view = self.pictureHash[user.facebookId];
    
    if (view == nil) {
        view = [[FBProfilePictureView alloc] initWithProfileID:user.facebookId
                                               pictureCropping:FBProfilePictureCroppingSquare];
        self.pictureHash[user.facebookId] = view;
    }
    
    return view;
}


@end
