//
//  VONewsFeedPostToolbar.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedPostFooter.h"

#import "VODesignFactory.h"

@interface VONewsFeedPostFooter ()

/**
 * @abstract
 *  Add the layout constraints associated with
 *  self.
 */
- (void)layoutSelf;

@end

@implementation VONewsFeedPostFooter

#pragma mark - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [VODesignFactory postFooterColor];
        [self layoutSelf];
    }
    return self;
}


- (void)layoutSelf {
    // Just add a height constraint.
    
    NSLayoutConstraint *heightConstraint =
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:0
                                    multiplier:1
                                      constant:20.f];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:heightConstraint];
}


@end
