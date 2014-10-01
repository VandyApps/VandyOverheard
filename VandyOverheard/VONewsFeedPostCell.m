//
//  NewsFeedPostCell.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostCell.h"

#import "VODesignFactory.h"
#import "VOPost.h"
#import "VOProfilePictureView.h"
#import "VOUser.h"

// TODO: Move these to the layout
// constraints, no longer need
// these up here.
static CGFloat UserViewDimensions = 40.0;
static CGFloat UserViewPadding = 15.0;

@interface VONewsFeedPostCell ()

#pragma mark - Private Properties

/**
 * @abstract
 *  A label describing the author
 *  that is responsible for the post.
 */
@property (nonatomic, strong) UILabel *authorLabel;

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
 *  author label.
 *
 * @discussion
 *  This method assumes that the authorLabel
 *  is initialized and added to the view hierarhchy.
 */
- (void)layoutAuthorLabel;

/**
 * @abstract
 *  Add the layout constraints to the
 *  user view.
 *
 * @discussion
 *  This method assumes that userView is
 *  initialized and added to the view
 *  hierarchy.  This method also assumes
 *  that the authorLabel is initialized and
 *  a sibling view to this view.
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
 *  a sibling to the content label.  This method
 *  also assumes that the author label is
 *  a sibling view to this view.
 */
- (void)layoutContentLabel;

@end

@implementation VONewsFeedPostCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // TODO: DO all this stuff in some setup method,
        // or by lazy instantiation.
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [VODesignFactory asideFont];
        _authorLabel.textColor = [VODesignFactory asideFontColor];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [VODesignFactory normalFont];
        _contentLabel.textColor = [VODesignFactory normalFontColor];
        
        _userView = [[VOProfilePictureView alloc] init];
        _userView.layer.cornerRadius = UserViewDimensions / 2.f;
        _userView.layer.borderColor = [VODesignFactory profilePicBorderColor].CGColor;
        _userView.layer.borderWidth = 2.0;

        [self addSubview:_authorLabel];
        [self layoutAuthorLabel];
        
        [self addSubview:_contentLabel];
        [self layoutContentLabel];
        
        [self addSubview:_userView];
        [self layoutUserView];

        _contentLabel.numberOfLines = 10;
    }
    return self;
}


#pragma mark - Accessors

- (void)setPost:(VOPost *)post {
    _post = post;

    _authorLabel.text = [NSString stringWithFormat:@"Posted by %@ %@",
                         post.author.firstName,
                         post.author.lastName];
    
    _userView.user = _post.author;
    _contentLabel.text = _post.body;
    
}


#pragma mark - Layout

- (void)layoutAuthorLabel {
    // TODO: Abstract out these checks into
    // some defined macros.
    NSAssert(self.authorLabel != nil,
             @"AuthorLabel must be initialized before calling layoutAuthorLabel.");
    NSAssert(self.authorLabel.superview != nil,
             @"AuthorLabel must be in the view hierarchy before calling layoutAuthorLabel");
    
    UIView *superview = self.authorLabel.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_authorLabel);
    
    NSDictionary *metrics = @{
                                @"top": @10,
                                @"left": @10
                              };
    
    static NSString *const vertVFL = @"V:|-top-[_authorLabel]";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:vertVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const horVFL = @"H:|-left-[_authorLabel]";
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
}


- (void)layoutUserView {
    // TODO: Abstract out these checks into some
    // defined macros.
    NSAssert(self.userView != nil,
             @"UserView must be initialized before calling layoutUserView.");
    NSAssert(self.userView.superview != nil,
             @"UserView must be in the view hierarchy before calling layoutUserView.");
    NSAssert(self.authorLabel != nil,
             @"AuthorLabel must be initialized before calling layoutUserView.");
    NSAssert(self.authorLabel.superview != nil,
             @"AuthorLabel must be in the view hierarchy before calling layoutUserView");
    
    UIView *superview = self.userView.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_authorLabel, _userView);
    
    NSDictionary *metrics = @{
                                @"top": @5,
                                @"left": @(UserViewPadding),
                                @"bottom": @20,
                                @"dimension": @(UserViewDimensions),
                              };
    
    static NSString *const vertVFL = @"V:[_authorLabel]-top-[_userView(dimension)]->=bottom-|";
    
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
    // TODO: Abstract out these checks into some
    // defined macros.
    NSAssert(self.contentLabel != nil,
             @"ContentLabel must be initialized before calling layoutContentLabel.");
    NSAssert(self.contentLabel.superview,
             @"ContentLabel must be added to the view hierarchy before calling layoutContentLabel.");
    NSAssert(self.authorLabel != nil,
             @"AuthorLabel must be initialized before calling layoutContentLabel.");
    NSAssert(self.authorLabel.superview != nil,
             @"AuthorLabel must be in the view hierarchy before calling layoutContentLabel");
    
    UIView *superview = self.contentLabel.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_authorLabel, _contentLabel);
    
    NSDictionary *metrics = @{
                                @"top": @10,
                                @"bottom": @20,
                                @"left": @(10 + UserViewDimensions + UserViewPadding),
                                @"right": @20
                              };
    static NSString *const verticalVFL = @"V:[_authorLabel]-top-[_contentLabel]->=bottom-|";
    
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
