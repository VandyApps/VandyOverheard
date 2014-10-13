//
//  VONewsFeedPostToolbar.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VOPost;

@interface VONewsFeedPostFooter : UIView

@property (nonatomic, strong) VOPost *post;

/**
 * @return The height of the footer.
 */
+ (CGFloat)height;

@end
