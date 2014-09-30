//
//  VONewsFeedDelegate.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/28/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_VONewsFeedDelegate_h
#define VandyOverheard_VONewsFeedDelegate_h

@class VONewsFeed;

@protocol VONewsFeedDelegate <NSObject>

- (void)newsFeedDidRefresh:(VONewsFeed *)newsFeed;

@end
#endif
