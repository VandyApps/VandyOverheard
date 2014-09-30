//
//  VOUser.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface VOUser : NSObject

/**
 * @abstract
 *  The first name of the user.
 */
@property (nonatomic, copy, readonly) NSString *firstName;

/**
 * @abstract
 *  The last name of the user.
 */
@property (nonatomic, copy, readonly) NSString *lastName;

/**
 * @abstract
 *  The facebook id of the user.
 */
@property (nonatomic, copy, readonly) NSString *facebookId;

/**
 * @abstract
 *  Designated initializer.
 *
 * @param firstName The first name of the user
 *
 * @param lastName The last name of the user
 *
 * @param facebookId The facebook id of the user.
 */
- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                               id:(NSString *)facebookId;

/**
 * @abstract
 *  Alternative initializer. This will create a user
 *  instance based on the Facebook Graph User.
 *
 * @param user The facebook graph user.
 */
- (instancetype)initWithFacebookUser:(id<FBGraphUser>)user;


@end
