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
 *  A picture of the content, if this post has
 *  a picture. Otherwise, nil.
 */
@property (nonatomic, strong) UIImageView *pictureView;

/**
 * @abstract
 *  The toolbar for the cell.
 */
@property (nonatomic, strong) VONewsFeedPostFooter *footer;

/**
 * @abstract
 *  Event handler for when the pictureView
 *  property is tapped.
 */
- (void)didTapPictureView:(id)sender;

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
 *  Add the layout constraints to the picture
 *  view.
 *
 * @discussion
 *  This method assumes that the pictureView
 *  is initialized and added to the view hierarchy.
 *  This method also assumes that the like button
 *  contentLabel are both laid out in the view as
 *  siblings of this view, both with their constraints
 *  set.
 */
- (void)layoutPictureView;

/**
 * @abstract
 *  Add the layout constraints for the footer.
 *
 * @discussion
 *  This method assumes that the footer is
 *  initialized and added to the view hierarchy.
 *  This method also assumes that the contentLabel
 *  and likeButton are added as siblings to this
 *  footer. This method also assumes that the
 *  pictureView is added as a sibling to this
 *  view if there is an image for the post.
 */
- (void)layoutFooter;

@end

@implementation VONewsFeedPostCell

#pragma mark - Static Methods

+ (CGFloat)estimatedHeightForPost:(VOPost *)post {
    CGFloat height = 0;
    
    // Calculate approximate height of text. Estimate
    // 35 characters per line and 20 points per line.
    height += ([post.body length] / 35) * 20;
    
    // If the post has a picture, estimate that the height of
    // the picture is 100 points.
    if (post.picture) {
        height += 100;
    }
    
    // Add the height of the footer
    height += [VONewsFeedPostFooter height];
    
    // Increment to account for underestimation
    height += 60;
    
    return height;
}


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

        _pictureView = [[UIImageView alloc] init];
        _pictureView.backgroundColor = [UIColor redColor];
        
        _footer = [[VONewsFeedPostFooter alloc] init];
        
        
        [self addSubview:_authorLabel];
        [self layoutAuthorLabel];
 
        [self addSubview:_userView];
        [self layoutUserView];
        
        [self addSubview:_likeButton];
        [self layoutLikeButton];
        
        [self addSubview:_contentLabel];
        [self layoutContentLabel];
        
        [self addSubview:_pictureView];
        [self layoutPictureView];
        
        [self addSubview:_footer];
        [self layoutFooter];
        
        // Add event handling here.
        UITapGestureRecognizer *tapGesture =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapPictureView:)];
        
        [_pictureView addGestureRecognizer:tapGesture];
        [_pictureView setUserInteractionEnabled:YES];
        
        _contentLabel.numberOfLines = 10;
    }
    return self;
}


#pragma mark - Events

- (void)didTapPictureView:(id)sender {
    NSAssert([sender isKindOfClass:[UITapGestureRecognizer class]],
             @"This event should only be called on a tap gesture.");
    NSAssert(self.post.picture != nil, @"ImageView tap event was fired even though post has no picture.");
    
    // Double check to make sure that the post has a picture
    // before calling this method.
    if (self.delegate) {
        [self.delegate newsFeedPostCell:self didSelectImageView:self.pictureView];
    }
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
    
    self.pictureView.image = _post.picture;
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
    NSArray *constraints = [BMAutolayoutBuilder constraintsForView:self.authorLabel
                                                           atPoint:CGPointMake(10, 10)];
    
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.authorLabel.superview addConstraints:constraints];
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
    
    static NSString *const vertVFL = @"V:[_authorLabel]-top-[_userView]->=bottom-|";
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:vertVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const horVFL = @"H:|-left-[_userView]";

    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    NSArray *sizeConstraints = [BMAutolayoutBuilder constraintsForView:self.userView
                                                              withSize:CGSizeMake(40, 40)];
    
    self.userView.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
    [self.userView addConstraints:sizeConstraints];
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


- (void)layoutPictureView {
    // TODO: Add assertions up here.
    
    UIView *superview = self.pictureView.superview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_likeButton, _pictureView, _contentLabel);
    NSDictionary *metrics = @{
                                @"top": @10
                              };

    NSArray *centerConstraints =
        [BMAutolayoutBuilder constraintsForHorizontalCenterView:self.pictureView];

    static NSString *const topVFL1 = @"V:[_likeButton]->=top-[_pictureView]";
    NSArray *topConstraints1 =
        [NSLayoutConstraint constraintsWithVisualFormat:topVFL1
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    static NSString *const topVFL2 = @"V:[_contentLabel]->=top-[_pictureView]";
    NSArray *topConstraints2 =
        [NSLayoutConstraint constraintsWithVisualFormat:topVFL2
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    self.pictureView.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:centerConstraints];
    [superview addConstraints:topConstraints1];
    [superview addConstraints:topConstraints2];
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
    
    NSDictionary *views =
        NSDictionaryOfVariableBindings(_footer, _contentLabel, _likeButton, _pictureView);
    

    static NSString *const verticalVFL = @"V:[_pictureView]->=top-[_footer]|";
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];
    
    [superview addConstraints:verticalConstraints];

    // Horizontal layout is the same with or without an image.
    static NSString *const horizonalVFL = @"H:|[_footer]|";
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizonalVFL
                                                options:0
                                                metrics:metrics
                                                  views:views];

    [superview addConstraints:horizontalConstraints];
}


@end
