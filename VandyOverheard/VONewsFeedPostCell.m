//
//  NewsFeedPostCell.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostCell.h"

#import "VOPost.h"
#import "VOProfilePictureView.h"
#import "VOUser.h"

static CGFloat UserViewDimensions = 40.0;
static CGFloat UserViewPadding = 10.0;

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
 *  The view displaying the user image.
 */
@property (nonatomic, strong) VOProfilePictureView *userView;

/**
 * @abstract
 *  Add the layout constraints to the
 *  user view.
 *
 * @discussion
 *  This method assumes that userView is
 *  initialized and added to the view
 *  hierarchy.
 */
- (void)layoutUserView;

/**
 * @abstract
 *  Add the layout constraints to the content
 *  label.
 *
 * @discussion
 *  This method assumes that the contentLabel
 *  property is initialized and added to the
 *  view hierarchy. This method also assumes
 *  the userView property is initialized
 *  and laid out in the view hierarchy as
 *  a sibling to the content label.
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
        _userView = [[VOProfilePictureView alloc] init];
        _userView.layer.cornerRadius = UserViewDimensions / 2.f;
        [self addSubview:_userView];
        [self layoutUserView];

        _contentLabel.numberOfLines = 10;
    }
    return self;
}


#pragma mark - Accessors

- (void)setPost:(VOPost *)post {
    _post = post;

    _userView.user = _post.author;
    _contentLabel.text = _post.body;
}


#pragma mark - Layout

- (void)layoutUserView {
    NSAssert(self.userView != nil,
             @"UserView must be initialized before calling layoutUserView.");
    NSAssert(self.userView.superview != nil,
             @"UserView must be in the view hierarchy before calling layoutUserView.");
             
    UIView *superview = self.userView.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userView);
    
    NSDictionary *metrics = @{
                                @"top": @10,
                                @"left": @(UserViewPadding),
                                @"bottom": @20,
                                @"dimension": @(UserViewDimensions),
                              };
    
    static NSString *const vertVFL = @"V:|-top-[_userView(dimension)]->=bottom-|";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:vertVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const horVFL = @"H:|-left-[_userView(dimension)]";

    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    self.userView.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
}


- (void)layoutContentLabel {
    NSAssert(self.contentLabel != nil,
             @"ContentLabel must be initialized before calling layoutContentLabel.");
    NSAssert(self.contentLabel.superview,
             @"ContentLabel must be added to the view hierarchy before calling layoutContentLabel.");
    
    UIView *superview = self.contentLabel.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_contentLabel);
    
    NSDictionary *metrics = @{
                                @"top": @10,
                                @"bottom": @20,
                                @"left": @(10 + UserViewDimensions + UserViewPadding),
                                @"right": @20
                              };
    static NSString *const verticalVFL = @"V:|-top-[_contentLabel]->=bottom-|";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const horizontalVFL = @"H:|-left-[_contentLabel]-right-|";
    
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
