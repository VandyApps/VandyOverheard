//
//  VODesignFactory.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VODesignFactory : NSObject

+ (UIFont *)headerFont;

+ (UIFont *)normalFont;

+ (UIFont *)asideFont;

+ (UIColor *)headerFontColor;

+ (UIColor *)normalFontColor;

+ (UIColor *)asideFontColor;

+ (UIColor *)mainAppColor;

+ (UIColor *)secondaryAppColor;

+ (UIColor *)navBarColor;

+ (UIColor *)navBarTextColor;

+ (UIColor *)profilePicBorderColor;

@end
