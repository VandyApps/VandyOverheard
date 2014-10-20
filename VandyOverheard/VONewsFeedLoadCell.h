//
//  VONewsFeedLoadCell.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/11/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @abstract
 *  Cell indicating that the tableview
 *  is loading.
 */
@interface VONewsFeedLoadCell : UITableViewCell

/**
 * @abstract
 *  YES if the cell is animating an activity
 *  indicator, NO otherwise.
 */
@property (nonatomic, assign, readonly) BOOL isAnimating;

/**
 * @abstract
 *  Starts animating the activity
 *  indicator in the cell.
 */
- (void)startAnimating;

@end
