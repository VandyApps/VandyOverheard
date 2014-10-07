//
//  VOAppContext.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/7/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VOAppContextFactory.h"

@class VOUser;

/**
 * @abstract
 *  A single access point to global data
 *  in the application. This method makes
 *  sure that all information is retrieved
 *  and initialized correctly.
 */
@interface VOAppContext : NSObject

/**
 * @abstract
 *  The current user of the application.
 */
@property (nonatomic, strong, readonly) VOUser *user;

/**
 * @abstract
 *  The access point for the app context
 *  singleton used in this application.
 *
 * @discussion The singleton instance
 *  can only be accessed after the method
 *  resetContextWithFactory: has been called.
 */
+ (VOAppContext *)sharedInstance;

/**
 * @abstract
 *  Signals the app context to reset itself.
 *
 * @param factory The factory used to set all
 *  the state in the app context.
 */
+ (void)resetContextWithFactory:(id<VOAppContextFactory>)factory;

@end
