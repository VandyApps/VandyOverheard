//
//  VONewsFeedLoadCell.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 10/11/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedLoadCell.h"

#import "BMAutolayoutBuilder.h"

@interface VONewsFeedLoadCell ()

/**
 * @abstract
 *  The load indicator inside the load view.
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadIndicatorView;

/**
 * @abstract
 *  Set up the layout constraints
 *  for the loadView.
 *
 * @discussion
 *  This method assumes that the load view has been initialized
 *  and the load view has been added to the view hierarchy
 *  of this table view cell.
 */
- (void)layoutLoadView;

@end

@implementation VONewsFeedLoadCell

#pragma mark - Accessors

- (BOOL)isAnimating {
    return _loadIndicatorView.isAnimating;
}


#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _loadIndicatorView = [[UIActivityIndicatorView alloc] init];
        [self addSubview:_loadIndicatorView];
        
        [self layoutLoadView];
        self.loadIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return self;
}


#pragma mark - ActivityIndicator

- (void)startAnimating {
    [self.loadIndicatorView startAnimating];
}


#pragma mark - Layout

- (void)layoutLoadView {
    NSAssert(self.loadIndicatorView != nil, @"loadView must be initialized before calling layoutLoadView.");
    NSAssert(self.loadIndicatorView.superview == self, @"loadView must be added to view hierarchy correctly.");
    
    NSArray *constraints = [BMAutolayoutBuilder constraintsForCenterView:self.loadIndicatorView];
    
    self.loadIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:constraints];
}


@end
