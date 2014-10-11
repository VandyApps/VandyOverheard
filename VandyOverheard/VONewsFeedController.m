//
//  VONewsFeedController.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/27/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "VONewsFeedController.h"

#import "BMAutolayoutBuilder.h"
#import "VOAppContext.h"
#import "VOFeedStore.h"
#import "VONewsFeed.h"
#import "VONewsFeedLoadCell.h"
#import "VONewsFeedPostCell.h"
#import "VONewsFeedRequest.h"
#import "VOPost.h"
#import "VOProfilePictureStore.h"

@interface VONewsFeedController () <UITableViewDataSource, UITableViewDelegate>

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
 *  The refresh ui for the news feed.
 */
@property (nonatomic, strong) UIRefreshControl *refreshControl;

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

/**
 * @abstract
 *  Refresh the UITableView to update content
 *  so that it contains the most up-to-date
 *  data from Facebook
 */
- (void)refreshTable;

@end

static NSString *const PostCellId = @"PostCell";
static NSString *const LoadCellId = @"LoadCell";

@implementation VONewsFeedController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Vandy Overheard";
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTable)
                  forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.

    // Setup the table view.
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    
    [self layoutTableView];

    
    [self.tableView registerClass:[VONewsFeedPostCell class]
           forCellReuseIdentifier:PostCellId];
    [self.tableView registerClass:[VONewsFeedLoadCell class]
           forCellReuseIdentifier:LoadCellId];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)viewWillAppear:(BOOL)animated {
    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    request.offset = 0;
    request.limit = 30;
    
    __weak VONewsFeedController *weakSelf = self;
    void(^requestBlock)(VONewsFeed *) = ^(VONewsFeed *feed) {
        weakSelf.newsFeed = feed;
        [[VOAppContext sharedInstance].profilePictureStore downloadProfilePicturesForNewsFeed:feed];
        [weakSelf.tableView reloadData];
    };
    [[VOAppContext sharedInstance].feedStore fetchNewsFeedWithRequest:request
                                                                block:requestBlock];
}


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.newsFeed.posts count]) {
        // This is the last cell in the table view.
        VONewsFeedLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellId
                                                                   forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        VONewsFeedPostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellId
                                                                   forIndexPath:indexPath];
        
        cell.post = [self.newsFeed.posts objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.newsFeed.posts count] == 0) {
        return 0;
    }
    else {
        // Add the load cell.
        return [self.newsFeed.posts count] + 1;
    }
}


#pragma mark - UITableViewDelegate Methods


#pragma mark - Refreshing TablView

- (void)refreshTable {
    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    request.offset = 0;
    request.limit = 30;
    
    __weak VONewsFeedController *weakSelf = self;
    void(^requestBlock)(VONewsFeed *) = ^(VONewsFeed *feed) {
        weakSelf.newsFeed = feed;
        [[VOAppContext sharedInstance].profilePictureStore downloadProfilePicturesForNewsFeed:feed];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView reloadData];
    };
    [[VOAppContext sharedInstance].feedStore fetchNewsFeedWithRequest:request
                                                                block:requestBlock];
}


#pragma mark - Layout

- (void)layoutTableView {
    NSAssert(self.tableView != nil, @"The tableView property cannot be nil.");
    NSAssert(self.tableView.superview == self.view,
             @"The superview of the table view is not correctly set.");
    
    NSArray *constraints = [BMAutolayoutBuilder constraintsForView:self.tableView
                                                        withInsets:UIEdgeInsetsZero];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:constraints];
}


@end
