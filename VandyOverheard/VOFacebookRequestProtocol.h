//
//  VONetworkRequestProtocol.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/14/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_VONetworkRequestProtocol_h
#define VandyOverheard_VONetworkRequestProtocol_h

/**
 * @abstract
 *  A protocol for creating requests that can
 *  be interpreted by the VONetworkAdapter.
 */
@protocol VOFacebookRequestProtocol <NSObject>

/**
 * @abstract
 *  The facebook fql path for the request.
 */
- (NSString *)path;

/**
 * @abstract
 *  Any parameters that will go into
 *  the request.
 */
- (NSDictionary *)params;

/**
 * @abstract
 *  A method that is called when the request
 *  has been successfully processed.
 *
 * @param json The json object that the response
 *  contains.
 */
- (void)successWithJson:(id)json;

/**
 * @abstract
 *  A method that is called when the
 *  request failed to process.
 *  
 *  @param error The error associated with the
 *  response.
 */
- (void)failureWithError:(NSError *)error;

@end

#endif
