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
 * @return The height this cell should be for a given
 *  post.
 *
 * @discussion This method is meant as a convenience
 *  method to calculate the height of the table view
 *  cell.
 */
+ (CGFloat)heightForCellWithPost:(VOPost *)post;

/**
 * @abstract
 *  The post being displayed by the cell.
 */
@property (nonatomic, strong) VOPost *post;

@end
