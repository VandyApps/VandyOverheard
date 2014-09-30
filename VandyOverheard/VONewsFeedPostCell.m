//
//  NewsFeedPostCell.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostCell.h"

#import "VOPost.h"

@interface VONewsFeedPostCell ()

#pragma mark - Private Properties
/**
 * @abstract
 *  The label displaying the main
 *  content of the post.
 */
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@end

@implementation VONewsFeedPostCell

#pragma mark - Accessors

- (void)setPost:(VOPost *)post {
    _post = post;
    if (_contentLabel) {
        _contentLabel.text = _post.body;
    }
}


#pragma mark - UI

- (void)awakeFromNib {
    if (self.post) {
        self.contentLabel.text = self.post.body;
    }
}


@end
