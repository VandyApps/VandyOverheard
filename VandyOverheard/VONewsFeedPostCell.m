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
@property (nonatomic, strong) UILabel *contentLabel;

/**
 * @abstract
 *  Add the layout constraints to the content
 *  label.
 *
 * @discussion
 *  This method assumes that the contentLable
 *  property is initialized and added to the
 *  view hierarchy.
 */
- (void)layoutContentLabel;

@end

@implementation VONewsFeedPostCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        [self layoutContentLabel];
        _contentLabel.numberOfLines = 10;
    }
    return self;
}


#pragma mark - Accessors

- (void)setPost:(VOPost *)post {
    _post = post;
    if (_contentLabel) {
        _contentLabel.text = _post.body;
    }
}


#pragma mark - Layout

- (void)layoutContentLabel {
    UIView *superview = self.contentLabel.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_contentLabel);
    
    NSDictionary *metrics = @{
                                @"vertPadding": @20,
                                @"horPadding": @20
                              };
    static NSString *const verticalVFL = @"V:|-vertPadding-[_contentLabel]-vertPadding-|";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const horizontalVFL = @"H:|-horPadding-[_contentLabel]-horPadding-|";
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizontalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
}


@end
