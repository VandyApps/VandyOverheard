//
//  VODesignFactory.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VODesignFactory.h"

@implementation VODesignFactory

+ (UIColor *)mainAppColor {
    return [UIColor colorWithRed:51/255.f green:87/255.f blue:130/255.f alpha:1];
}


+ (UIColor *)secondaryAppColor {
    return [UIColor colorWithRed:221/255.f green:118/255.f blue:53/255.f alpha:1];
}


+ (UIColor *)navBarColor {
    return [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:.1];
}


+ (UIColor *)navBarTextColor {
    return [UIColor whiteColor];
}


@end
