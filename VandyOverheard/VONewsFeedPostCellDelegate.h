//
//  VOnewsFeedPostCellDelegate.h
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/20/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#ifndef VandyOverheard_VONewsFeedPostCellDelegate_h
#define VandyOverheard_VONewsFeedPostCellDelegate_h

@class VONewsFeedPostCell;
@class UIImageView;

@protocol VONewsFeedPostCellDelegate <NSObject>

/**
 * @abstract
 *  This delegate method is called when the picture view is selected for
 *  a particular image.
 */
- (void)newsFeedPostCell:(VONewsFeedPostCell *)cell didSelectImageView:(UIImageView *)imageView;

@end
#endif
