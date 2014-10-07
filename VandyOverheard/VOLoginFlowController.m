//
//  VOLoginFlowController.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VOLoginFlowController.h"

#import "VOLoginViewController.h"

static NSTimeInterval TransitionDuration = 0.3f;

@interface VOLoginFlowController ()

#pragma mark - Private Properties

/**
 * @abstract
 *  The view controller that handles logins.
 */
@property (nonatomic, strong) VOLoginViewController *loginController;

#pragma mark - Private Methods

/**
 * @abstract
 *  Add a view controller to this container view
 *  controller.
 *
 * @param controller The controller to add.
 *
 */
- (void)addController:(UIViewController *)controller;

/**
 * @abstract
 *  Remove a view controller from this container view.
 *
 * @param controller The controller to remove from
 *  this container controller. This method assumes
 *  that the controller is a member of this
 *  container controller.
 */
- (void)removeController:(UIViewController *)controller;

/**
 * @abstract
 *  Add the constraints to this controller.
 *
 * @param controller The controller to set the
 *  constraints for.
 *
 * @param presented If YES, the layout constraints
 *  will be added such that this controller will be
 *  present. Otherwise, the controller will be
 *  laid out such that it is not present.
 *
 * @return An array of all the constraints
 *  that were applied to the controller.
 */
- (NSArray *)createConstraintsForController:(UIViewController *)controller
                               presented:(BOOL)presented;

/**
 * @abstract
 *  Perform a transition between two view controllers.
 *
 * @param fromController The controller to transition from.
 *
 * @param toController The controller to transition to.
 */
- (void)transitionFromViewController:(UIViewController *)fromController
                    toViewController:(UIViewController *)toController;

/**
 * @abstract
 *  Handles all the logic involved with logging in.
 */
- (void)didLogin;

/**
 * @abstract
 *  Handles all the logic involved with logging out.s
 */
- (void)didLogout;

@end

@implementation VOLoginFlowController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginController = [[VOLoginViewController alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.loginController.isLoggedIn) {
        [self addController:self.destinationController];
        NSArray *constraints = [self createConstraintsForController:self.destinationController
                                                          presented:YES];
        [self.view addConstraints:constraints];
        self.destinationController.view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    else {
        [self addController:self.loginController];
        NSArray *constraints = [self createConstraintsForController:self.loginController
                                                          presented:YES];
        
        [self.view addConstraints:constraints];
        self.loginController.view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    __weak VOLoginFlowController *weakSelf = self;
    self.loginController.loginCallback = ^(VOUser *user) {
        if (weakSelf.delegate) {
            [weakSelf.delegate loginFlowController:weakSelf didLoginWithUser:user];
        }
        [weakSelf didLogin];
    };
}


#pragma mark - Transitions

- (void)transitionFromViewController:(UIViewController *)fromController
                    toViewController:(UIViewController *)toController {
    
    [self addController:toController];
    NSArray *toConstraints = [self createConstraintsForController:toController
                                                     presented:NO];

    toController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:toConstraints];

    [self.view layoutIfNeeded];

    [self.view removeConstraints:toConstraints];
    
    toConstraints = [self createConstraintsForController:toController presented:YES];
    [self.view addConstraints:toConstraints];
    
    [UIView animateWithDuration:TransitionDuration
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeController:fromController];
                         }
                     }];
}


- (void)addController:(UIViewController *)controller {
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
}


- (void)removeController:(UIViewController *)controller {
    [controller willMoveToParentViewController:nil];
    [controller removeFromParentViewController];
    [controller.view removeFromSuperview];
}


- (NSArray *)createConstraintsForController:(UIViewController *)controller presented:(BOOL)presented {
    
    NSMutableArray *containerConstraints = [[NSMutableArray alloc] init];
    
    NSDictionary *views = @{@"view": controller.view};
    
    static NSString *const verticalVFL = @"V:|[view]|";

    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];
    
    [containerConstraints addObjectsFromArray:verticalConstraints];
    
    if (presented) {
        static NSString *const horizontalVFL = @"H:|[view]|";
        
        NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizontalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];
        
        [containerConstraints addObjectsFromArray:horizontalConstraints];
    }
    else {
        NSLayoutConstraint *leftConstraint =
        [NSLayoutConstraint constraintWithItem:controller.view
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0];
        NSLayoutConstraint *widthConstraint =
        [NSLayoutConstraint constraintWithItem:controller.view
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:1
                                      constant:0];
        
        [containerConstraints addObjectsFromArray:@[leftConstraint, widthConstraint]];
    }
    
    return [containerConstraints copy];
}


#pragma mark - Login/Logout

- (void)didLogin {
    
    // This method assumes that the login controller is present
    // and the loginConstraints are set.
    NSAssert(self.loginController != nil, @"Login Controller must be set when didLogin is called.");
    
    if (self.destinationController == nil) {
        @throw [NSException exceptionWithName:@"Undefined Controller"
                                       reason:@"Destination Controller cannot be nil during login process."
                                     userInfo:nil];
    }

    [self transitionFromViewController:self.loginController
                      toViewController:self.destinationController];
}


- (void)didLogout {
    // This method assumes that the destination constraints
    // and destination controller are present.
    NSAssert(self.destinationController != nil,
             @"destinationController should be present when didLogout is called.");
    
    NSAssert(self.loginController != nil, @"Login Controller cannot be nil.");
    
    [self transitionFromViewController:self.destinationController
                      toViewController:self.loginController];
}


@end
