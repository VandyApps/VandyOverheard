//
//  VOAppContext.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOAppContext.h"

static VOAppContext *instance;

@interface VOAppContext ()

/**
 * @abstract
 *  Private, designated initializer.
 *
 * @param factory The factory used to set the
 *  internal state.
 */
- (instancetype)initWithFactory:(id<VOAppContextFactory>)factory;

@end

@implementation VOAppContext

#pragma mark - Class Methods

+ (VOAppContext *)sharedInstance {
    if (instance == nil) {
        @throw [NSException exceptionWithName:@"AppContext does not exist"
                                       reason:@"You must call resetContextWithFactory: "
                                               "before trying to access the AppContext"
                                     userInfo:nil];
    }
    return instance;
}


+ (void)resetContextWithFactory:(id<VOAppContextFactory>)factory {
    instance = [[VOAppContext alloc] initWithFactory:factory];
}


#pragma mark - Initializers

- (instancetype)initWithFactory:(id<VOAppContextFactory>)factory {
    self = [super init];
    if (self) {
        _user = [factory createCurrentUser];
        _profilePictureStore = [factory createProfilePictureStore];
        _feedStore = [factory createFeedStore];
    }
    return self;
}


- (instancetype)init {
    @throw [NSException exceptionWithName:@"Incorrect Initialization"
                                   reason:@"Must access VOAppContext through sharedInstance"
                                 userInfo:nil];
    return nil;
}


@end
