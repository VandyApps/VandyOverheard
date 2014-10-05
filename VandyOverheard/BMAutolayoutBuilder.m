//
//  AutolayoutBuilder.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/5/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "BMAutolayoutBuilder.h"
#import "BMAutolayoutMacros.h"

@implementation BMAutolayoutBuilder

+ (NSArray *)constraintsForView:(UIView *)view
                     withInsets:(UIEdgeInsets)insets {

    AssertConstraintReady(view);
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSDictionary *metrics = @{
                                @"top": @(insets.top),
                                @"bottom": @(insets.bottom),
                                @"left": @(insets.left),
                                @"right": @(insets.right)
                              };
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view]-bottom-|"
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|"
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    return [verticalConstraints arrayByAddingObjectsFromArray:horizontalConstraints];
}


+ (NSArray *)constraintsForVerticalCenterView:(UIView *)view {
    
    AssertConstraintReady(view);
    
    return @[[NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeCenterY
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:view.superview
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1 constant:0]];
}


+ (NSArray *)constraintsForHorizontalCenterView:(UIView *)view {
    
    AssertConstraintReady(view);
    
    return @[[NSLayoutConstraint constraintWithItem:view
                                          attribute:NSLayoutAttributeCenterX
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:view.superview
                                          attribute:NSLayoutAttributeCenterX
                                         multiplier:1 constant:0]];
}


+ (NSArray *)constraintsForCenterView:(UIView *)view {
    
    NSArray *horizontalCenter = [self constraintsForHorizontalCenterView:view];
    NSArray *verticalCenter = [self constraintsForVerticalCenterView:view];
    
    return [horizontalCenter arrayByAddingObjectsFromArray:verticalCenter];
}


@end
