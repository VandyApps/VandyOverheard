//
//  VOAppContextFactory.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_VOAppContextFactory_h
#define VandyOverheard_VOAppContextFactory_h

@class VOUser;

@protocol VOAppContextFactory <NSObject>

/**
 * @abstract
 *  Create a current user instance. This
 *  method is synchronous.
 *
 * @discussion createCurrentUser should never
 *  return nil.
 */
- (VOUser *)createCurrentUser;

@end

#endif