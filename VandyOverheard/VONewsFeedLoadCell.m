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
@property (nonatomic, strong) UIActivityIndicatorView *loadView;

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
    return _loadView.isAnimating;
}


#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _loadView = [[UIActivityIndicatorView alloc] init];
        [self addSubview:_loadView];
        
        [self layoutLoadView];
        self.loadView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return self;
}


#pragma mark - ActivityIndicator

- (void)startAnimating {
    [self.loadView startAnimating];
}


#pragma mark - Layout

- (void)layoutLoadView {
    NSAssert(self.loadView != nil, @"loadView must be initialized before calling layoutLoadView.");
    NSAssert(self.loadView.superview == self, @"loadView must be added to view hierarchy correctly.");
    
    NSArray *constraints = [BMAutolayoutBuilder constraintsForCenterView:self.loadView];
    
    self.loadView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:constraints];
}


@end
