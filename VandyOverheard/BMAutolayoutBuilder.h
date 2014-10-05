//
//  AutolayoutBuilder.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/5/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @abstract
 *  Convenience wrapper over autolayout
 *  constraints that makes designing
 *  common constraints easier in code.
 */
@interface BMAutolayoutBuilder : NSObject

/**
 * @abstract
 *  Creates a set of layout constraints such that
 *  the view will have the given insets within
 *  its superview.
 *
 * @param view The view to create the constraints
 *  for. This view should be added to some view
 *  hierarchy and must have a superview.
 *
 * @param insets The insets to create for the view.
 */
+ (NSArray *)constraintsForView:(UIView *)view
                     withInsets:(UIEdgeInsets)insets;

/**
 * @abstract
 *  Creates a set of constraints that vertically center
 *  the view in its superview.
 *
 * @param view The view to vertically center. Note that
 *  this view must be initialized and must have a superview.
 */
+ (NSArray *)constraintsForVerticalCenterView:(UIView *)view;

/**
 * @abstract
 *  Creates a set of constraints that horizontally
 *  center the view in its superview.
 *
 * @param view The view to horizontally center. Note that
 *  this view must be initialized and must have a superview.
 */
+ (NSArray *)constraintsForHorizontalCenterView:(UIView *)view;

/**
 * @abstract
 *  Creates a set of constraints that vertically and horizontally
 *  center a view inside its superview.
 *
 * @param view The view to center. Note that this view must be
 *  initialized and have a superview.
 */
+ (NSArray *)constraintsForCenterView:(UIView *)view;

@end
