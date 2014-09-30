//
//  VONetworkAdapter.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkResponseBlock)(id result, NSError *error);

@interface VONetworkAdapter : NSObject

/**
 * @abstract
 *  Loads the main thread of the newsfeed. The results
 *  will be passed to the reponse block parameter.
 *  This method will be called asynchronously but
 *  the response block will be executed on the
 *  main thread.
 */
- (void)loadMainThread:(NetworkResponseBlock)response;

@end
