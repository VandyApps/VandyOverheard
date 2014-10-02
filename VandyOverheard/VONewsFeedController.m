//
//  VONewsFeedController.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/27/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedController.h"

#import "VONewsFeed.h"
#import "VONewsFeedPostCell.h"

@interface VONewsFeedController () <UITableViewDataSource, UITableViewDelegate, VONewsFeedDelegate>

/**
 * @abstract
 *  The news feed data associated with this
 *  controller.
 */
@property (nonatomic, strong) VONewsFeed *newsFeed;

/**
 * @abstract
 *  The table view that is presenting the news feed.
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 * @abstract
 *  Set the autolayout constaints for the table view
 *  property.
 *
 * @discussion
 *  This method assumes that the tableView property
 *  is initialized and added to the view hierarchy.
 */
- (void)layoutTableView;

@end

static NSString *const PostCellId = @"PostCell";

@implementation VONewsFeedController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Vandy Overheard";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.newsFeed = [[VONewsFeed alloc] init];
    self.newsFeed.delegate = self;
    // Do any additional setup after loading the view.

    // Setup the table view.
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self layoutTableView];

    
    [self.tableView registerClass:[VONewsFeedPostCell class]
           forCellReuseIdentifier:PostCellId];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)viewWillAppear:(BOOL)animated {
    [self.newsFeed refresh];
}


#pragma mark - VONewsFeedDelegate

- (void)newsFeedDidRefresh:(VONewsFeed *)newsFeed {
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VONewsFeedPostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellId
                                                               forIndexPath:indexPath];
    
    cell.post = [self.newsFeed.posts objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsFeed.posts count];
}


#pragma mark - UITableViewDelegate Methods


#pragma mark - Layout

- (void)layoutTableView {
    NSAssert(self.tableView != nil, @"The tableView property cannot be nil.");
    
    UIView *superview = self.tableView.superview;
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);

    static NSString *const verticalVFL = @"V:|[_tableView]|";
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:verticalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];
    
    static NSString *const horizontalVFL = @"H:|[_tableView]|";
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:horizontalVFL
                                                options:0
                                                metrics:nil
                                                  views:views];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addConstraints:verticalConstraints];
    [superview addConstraints:horizontalConstraints];
}


@end
