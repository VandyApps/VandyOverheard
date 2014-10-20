//
//  NewsFeedPostCell.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 *  The post being displayed by the cell.
 */
@property (nonatomic, strong) VOPost *post;

@end
