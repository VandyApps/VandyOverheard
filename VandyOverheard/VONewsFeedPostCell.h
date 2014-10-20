//
//  NewsFeedPostCell.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VONewsFeedPostCellDelegate.h"

@class VOPost;

@interface VONewsFeedPostCell : UITableViewCell

/**
 * @abstract
 *  Get the estimated height of a cell that is presenting
 *  the given post.
 */
+ (CGFloat)estimatedHeightForPost:(VOPost *)post;

/**
 * @abstract
 *  Delegate for handling events fired by the post cell.
 */
@property (nonatomic, weak) id<VONewsFeedPostCellDelegate> delegate;

/**
 * @abstract
 *  The post being displayed by the cell.
 */
@property (nonatomic, strong) VOPost *post;

@end
