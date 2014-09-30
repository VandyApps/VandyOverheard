//
//  VOLoginFlowController.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VOLoginFlowDelegate.h"

@interface VOLoginFlowController : UIViewController

/**
 * @abstract
 *  The view controller that will get presented
 *  as soon as a user is logged in. This should
 *  be set before logging in.
 */
@property (nonatomic, strong) UIViewController *destinationController;

/**
 * @abstract
 *  The delegate for the login flow.
 *  The delegate is optional.
 */
@property (nonatomic, weak) id<VOLoginFlowDelegate> delegate;

@end
