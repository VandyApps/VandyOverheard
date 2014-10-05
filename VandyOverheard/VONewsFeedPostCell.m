//
//  NewsFeedPostCell.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/30/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostCell.h"

#import "BMAutolayoutBuilder.h"

#import "VODesignFactory.h"
#import "VONewsFeedPostFooter.h"
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
 *  The like button for the post.
 */
@property (nonatomic, strong) UIButton *likeButton;

/**
 * @abstract
 *  The toolbar for the cell.
 */
@property (nonatomic, strong) VONewsFeedPostFooter *footer;

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
 *  Add the layout constraints for the
 *  like button.
 *
 * @discussion
 *  This method assumes that the like
 *  button is initialized and added
 *  to the view hierarchy. The like button
 *  must be a sibling to the user view.
 */
- (void)layoutLikeButton;

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

/**
 * @abstract
 *  Add the layout constraints for the footer.
 *
 * @discussion
 *  This method assumes that the footer is
 *  initialized and added to the view hierarchy.
 *  This method also assumes that the contentLabel
 *  and likeButton are added as siblings to this
 *  footer.
 */
- (void)layoutFooter;

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
        
        _likeButton = [[UIButton alloc] init];
        [_likeButton setImage:[VODesignFactory likeUnselectedImage] forState:UIControlStateNormal];
        [_likeButton setImage:[VODesignFactory likeSelectedImage] forState:UIControlStateSelected];
        
        _userView = [[VOProfilePictureView alloc] init];
        _userView.layer.cornerRadius = UserViewDimensions / 2.f;
        _userView.layer.borderColor = [VODesignFactory profilePicBorderColor].CGColor;
        _userView.layer.borderWidth = 2.0;

        _footer = [[VONewsFeedPostFooter alloc] init];
        
        
        [self addSubview:_authorLabel];
        [self layoutAuthorLabel];
 
        [self addSubview:_userView];
        [self layoutUserView];
        
        [self addSubview:_likeButton];
        [self layoutLikeButton];
        
        [self addSubview:_contentLabel];
        [self layoutContentLabel];
        
        [self addSubview:_footer];
        [self layoutFooter];
        
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
    _footer.post = _post;
    
}


#pragma mark - Layout

- (void)layoutLikeButton {
    // TODO: Asbtract out these checks
    NSAssert(self.likeButton != nil,
             @"LikeButton must be initialized before calling layoutLikeButton.");
    NSAssert(self.likeButton.superview != nil,
             @"LikeButton must be added to the view hierarchy before calling layoutLikeButton.");
    NSAssert(self.userView != nil, @"UserView must be initialized before calling layoutLikeButton");
    
    // TODO: Add macro for checking if views are siblings
    NSAssert(self.userView.superview == self.likeButton.superview,
            @"LikeButton and UserView must be siblings when calling layoutLikeButton");
    
    UIView *superview = self.likeButton.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_likeButton, _userView);
    
    NSDictionary *metrics = @{
                                @"top": @7,
                                @"bottom": @10,
                                @"height": @17
                              };
    
    static NSString *const vertVFL = @"V:[_userView]-top-[_likeButton(height)]->=bottom-|";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:vertVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    NSLayoutConstraint *horizontalCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.likeButton
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.userView
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.0 constant:0];
    
    NSLayoutConstraint *aspectRatioConstraint =
        [NSLayoutConstraint constraintWithItem:self.likeButton
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.likeButton
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1 constant:0];
    
    self.likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraint:aspectRatioConstraint];
    [superview addConstraint:horizontalCenterConstraint];
}


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
    
    
    // TODO: Modify constraints to account for user view.
    
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


- (void)layoutFooter {
    // TODO: Abstract out these checks into some
    // defined macros.
    NSAssert(self.footer != nil,
             @"Footer must be initialized before calling layoutFooter.");
    NSAssert(self.footer.superview != nil,
             @"Footeer must be in the view hierarchy before calling layoutFooter.");
    NSAssert(self.contentLabel.superview == self.footer.superview,
             @"ContentLabel must be a sibling of the footer view.");
    
    UIView *superview = self.footer.superview;
    
    NSDictionary *metrics = @{
                                @"top": @15
                              };
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_footer, _contentLabel, _likeButton);
    
    
    static NSString *const verticalVFL1 = @"V:[_contentLabel]->=top-[_footer]|";
    static NSString *const verticalVFL2 = @"V:[_likeButton]->=top-[_footer]|";
    
    NSArray *verticalConstraints1 =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL1
                                                options:0
                                                metrics:metrics
                                                  views:views];

    NSArray *verticalConstraints2 =
    [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL2
                                            options:0
                                            metrics:metrics
                                              views:views];

    
    static NSString *const horizonalVFL = @"H:|[_footer]|";
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizonalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    [superview addConstraints:verticalConstraints1];
    [superview addConstraints:verticalConstraints2];
    [superview addConstraints:horizontalConstraints];
}


@end
