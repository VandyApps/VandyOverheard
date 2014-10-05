//
//  VODesignFactory.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VODesignKey) {
    VODesignKeyPostFooter
};

@interface VODesignFactory : NSObject

// TODO: Migrate all methods to
// use the fontKey and colorKey
// options.

// Fonts

+ (UIFont *)headerFont;

+ (UIFont *)normalFont;

+ (UIFont *)asideFont;

/**
 * @abstract
 *  Get the font for a given key.
 */
+ (UIFont *)fontForKey:(VODesignKey)key;

// Colors

+ (UIColor *)headerFontColor;

+ (UIColor *)normalFontColor;

+ (UIColor *)asideFontColor;

+ (UIColor *)mainAppColor;

+ (UIColor *)secondaryAppColor;

+ (UIColor *)navBarColor;

+ (UIColor *)navBarTextColor;

+ (UIColor *)profilePicBorderColor;

/**
 * @abstract
 *  Get the color for the given key.
 */
+ (UIColor *)postFooterColor;

+ (UIColor *)colorForKey:(VODesignKey)key;

// Images

+ (UIImage *)likeSelectedImage;

+ (UIImage *)likeUnselectedImage;

@end
