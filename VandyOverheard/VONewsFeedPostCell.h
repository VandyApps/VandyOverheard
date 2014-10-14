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

@end
