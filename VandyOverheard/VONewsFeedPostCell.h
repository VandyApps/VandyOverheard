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
 *  The post being displayed by the cell.
 */
@property (nonatomic, strong) VOPost *post;

/**
 * @abstract
 *  Calculates the height the cell should be
 *  for the given post.
 *
 * @discussion
 *  All the data for the post must be loaded
 *  when passed into this method. This includes
 *  the picture and link for the post.
 *
 * @param post The post to calculate the height
 *  for.
 *
 * @return The height of any cell presenting
 *  the given post.
 */
+ (CGFloat)heightForCellWithPost:(VOPost *)post;

@end
