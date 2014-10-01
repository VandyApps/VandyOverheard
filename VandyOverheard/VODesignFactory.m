//
//  VODesignFactory.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VODesignFactory.h"

@implementation VODesignFactory

#pragma mark - Fonts

+ (UIFont *)headerFont {
    return [UIFont fontWithName:@"Helvetica" size:20];
}


+ (UIFont *)normalFont {
    return [UIFont fontWithName:@"Helvetica" size:16];
}


+ (UIFont *)asideFont {
    return [UIFont fontWithName:@"Helvetica" size:12];
}


#pragma mark - Colors

+ (UIColor *)mainAppColor {
    return [UIColor colorWithRed:51/255.f green:87/255.f blue:130/255.f alpha:1];
}


+ (UIColor *)secondaryAppColor {
    return [UIColor colorWithRed:221/255.f green:118/255.f blue:53/255.f alpha:1];
}


+ (UIColor *)profilePicBorderColor {
    return [self mainAppColor];
}


+ (UIColor *)navBarColor {
    return [self secondaryAppColor];
}


+ (UIColor *)navBarTextColor {
    return [UIColor whiteColor];
}

#pragma mark Font Colors

+ (UIColor *)headerFontColor {
    return [UIColor blackColor];
}


+ (UIColor *)normalFontColor {
    return [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1];
}


+ (UIColor *)asideFontColor {
    return [self mainAppColor];
}

@end
