//
//  VONewsFeedPostToolbar.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostFooter.h"

#import "VODesignFactory.h"
#import "VOPost.h"

@interface VONewsFeedPostFooter ()

/**
 * @abstract
 *  The label containing footer information
 *  about the post.
 */
@property (nonatomic, strong) UILabel *footerLabel;

/**
 * @abstract
 *  Add the layout constraints associated with
 *  self.
 *
 * @discussion The footerLabel must be initialized
 *  and added to the view hierarchy before this method
 *  is called.
 */
- (void)layoutSelf;

@end

@implementation VONewsFeedPostFooter

#pragma mark - Accessors

- (void)setPost:(VOPost *)post {
    _post = post;
    
    NSString *likeText;
    
    if (post.likeCount == 0) {
        likeText = @"No Likes";
    }
    else if (post.likeCount == 1) {
        likeText = @"1 Like";
    }
    else {
        likeText = [NSString stringWithFormat:@"%lu Likes", post.likeCount];
    }
    
    NSString *replyText;
    
    if ([post.replies count] == 0) {
        replyText = @"No Replies";
    }
    else if ([post.replies count] == 1) {
        replyText = @"1 Reply";
    }
    else {
        replyText = [NSString stringWithFormat:@"lu Replies"];
    }

    _footerLabel.text = [NSString stringWithFormat:@"%@ • %@", likeText, replyText];
}


#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [VODesignFactory postFooterColor];
        _footerLabel = [[UILabel alloc] init];
        [self addSubview:_footerLabel];
        
        // TODO: Create categories that do this for
        // UI Elements.
        _footerLabel.font = [VODesignFactory fontForKey:VODesignKeyPostFooter];
        _footerLabel.textColor = [VODesignFactory colorForKey:VODesignKeyPostFooter];
        [self layoutSelf];
    }
    return self;
}


- (void)layoutSelf {
    
    // TODO: Perform common autolayout assertions here.
    NSDictionary *views = NSDictionaryOfVariableBindings(_footerLabel);
    
    NSArray *horizontaFooterConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"|-(15)-[_footerLabel]-|"
                                                options:0
                                                metrics:nil
                                                  views:views];
    
    
    NSLayoutConstraint *verticalCenterConstraint =
        [NSLayoutConstraint constraintWithItem:self.footerLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.footerLabel.superview
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1 constant:0];
    // Just add a height constraint.
    NSLayoutConstraint *heightConstraint =
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:0
                                    multiplier:1
                                      constant:20.f];
    
    self.footerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:horizontaFooterConstraints];
    [self addConstraint:verticalCenterConstraint];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:heightConstraint];
}


@end
