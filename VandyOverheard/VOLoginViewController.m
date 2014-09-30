//
//  VOLoginViewController.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOLoginViewController.h"

#import <FacebookSDK/FacebookSDK.h>

#import "VODesignFactory.h"
#import "VONewsFeedDelegate.h"
#import "VOUser.h"

@interface VOLoginViewController () <FBLoginViewDelegate>

#pragma mark - Private Properties

#pragma mark IBOutlet Properties

/**
 * @abstract
 *  The parent view to the login button.
 */
@property (nonatomic, strong) IBOutlet UIView *loginWrapperView;

#pragma mark Other Properties

/**
 * @abstract
 *  The login button to login with facebook.
 */
@property (nonatomic, strong) FBLoginView *loginButton;

@property (nonatomic, assign) BOOL isLoggedIn;

#pragma mark - Private Methods

/**
 * @abstract
 *  Layout the login button in the controller.
 *
 * @discussion
 *  This method assumes that the login button
 *  is initialized and has a superview.
 */
- (void)layoutLoginButton;

@end

@implementation VOLoginViewController

#pragma mark - Initialization

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.loginButton = [[FBLoginView alloc] initWithReadPermissions:@[@"user_groups"]];
        self.loginButton.delegate = self;
    }
    return self;
}


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [VODesignFactory mainAppColor];
    [self.loginWrapperView addSubview:self.loginButton];
    [self layoutLoginButton];
}


#pragma mark - Layout

- (void)layoutLoginButton {
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    // TODO: Create a builder class to construct common constraints.
    NSLayoutConstraint *horizontalCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.loginButton.superview
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                      constant:0];
    
    NSLayoutConstraint *verticalCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.loginButton
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.loginButton.superview
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    
    [self.loginButton.superview addConstraint:horizontalCenterConstraint];
    [self.loginButton.superview addConstraint:verticalCenterConstraint];
}


#pragma mark - FBLoginViewDeletate Methods

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
#warning Handle Errors Here
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    if (self.loginCallback && !self.isLoggedIn) {
        self.loginCallback([[VOUser alloc] initWithFacebookUser:user]);
    }
    self.isLoggedIn = YES;
}


- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.isLoggedIn = NO;
}


@end
