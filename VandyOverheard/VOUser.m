//
//  VOUser.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOUser.h"

@implementation VOUser

#pragma mark - Initialization

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                               id:(NSString *)facebookId {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _facebookId = facebookId;
    }
    return self;
}


- (instancetype)initWithFacebookUser:(id<FBGraphUser>)user {
    self = [self initWithFirstName:user.first_name
                          lastName:user.last_name
                                id:user.objectID];
    return self;
}


- (instancetype)init {
    NSAssert(NO, @"To create a VOUser, you must use the initializer %@",
             NSStringFromSelector(@selector(initWithUser:)));
    return nil;
}


@end
