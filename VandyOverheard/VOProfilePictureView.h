//
//  VOProfilePictureView.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOUser;

@interface VOProfilePictureView : UIView

/**
 * @abstract
 *  The user associated with the profile
 *  picture.
 */
@property (nonatomic, strong) VOUser *user;

@end
