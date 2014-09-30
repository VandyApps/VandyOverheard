//
//  VOLoginViewController.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOUser;

@interface VOLoginViewController : UIViewController

/**
 * @abstract
 *  A callback that will notify when a user is logged in.
 *  This callback will return a VOUser object of the
 *  logged in user.
 */
@property (nonatomic, copy) void (^loginCallback)(VOUser *user);

/**
 * @return YES if the user is logged in, NO otherwise.
 */
@property (nonatomic, assign, readonly) BOOL isLoggedIn;

@end
