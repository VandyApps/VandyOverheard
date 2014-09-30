//
//  LoginFlowDelegate.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_LoginFlowDelegate_h
#define VandyOverheard_LoginFlowDelegate_h

@class VOUser;
@class VOLoginFlowController;

@protocol VOLoginFlowDelegate <NSObject>

/**
 * @abstract
 *  This method is called by the LoginFlowController
 *  when a user has been logged in.
 *
 * @discussion
 *  This method is called before the destinationController
 *  is presented. This is the last chance for any state
 *  to be set before the destinationController is presented.
 */
- (void)loginFlowController:(VOLoginFlowController *)controller
           didLoginWithUser:(VOUser *)user;

@end

#endif
