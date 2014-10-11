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

static NSInteger NewsFeedLimit = 30;

@interface VONewsFeedController () <UITableViewDataSource, UITableViewDelegate>

/**
 * @abstract
 *  The last offset that was used to fetch the news feed.
 */
@property (nonatomic, assign) NSInteger currentOffset;

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
 *
 * @discussion
 *  This method is meant to be used in conjunction
 *  with the UIRefreshControl.
 */
- (void)refreshControlValueDidChange;

/**
 * @abstract
 *  Refreshes the table view using a delta value
 *  that indicates how many posts have been
 *  added since the last refresh.  This allows
 *  for table view optimizations when loading.
 *  This method simply updates the current newsfeed
 *  with the UI in the table view.
 *
 * @discussion
 *  This method should NEVER be called when loading
 *  the table view for the first time. This should
 *  only be called if there are posts in the table view
 *  already being displayed, and a refresh is being
 *  called. Incorrect delta values with can cause an
 *  exception to be thrown by the table view. This method
 *  assumes that the newsfeed has been updated before
 *  it is called.
 */
- (void)refreshTableWithDelta:(NSInteger)delta;
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
                            action:@selector(refreshControlValueDidChange)
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
    self.currentOffset = 0;
    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    request.offset = self.currentOffset;
    request.limit = NewsFeedLimit;
    
    __weak VONewsFeedController *weakSelf = self;
    void(^requestBlock)(VONewsFeed *, NSInteger) = ^(VONewsFeed *feed, NSInteger delta) {
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
        
        // Whenever the load cell is reached in the table view,
        // that means it is time to load more items into the
        // news feed. Load cell is at the end of the table view.
        self.currentOffset += 1;

        VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
        request.limit = NewsFeedLimit;
        request.offset = self.currentOffset;
        
        NSLog(@"Time to reload");
        
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


#pragma mark - Refreshing UITableView

- (void)refreshControlValueDidChange {
    VONewsFeedRequest *request = [[VONewsFeedRequest alloc] init];
    self.currentOffset = 0;
    request.offset = 0;
    request.limit = NewsFeedLimit;
    
    __weak VONewsFeedController *weakSelf = self;
    void(^requestBlock)(VONewsFeed *, NSInteger) = ^(VONewsFeed *feed, NSInteger delta) {
        weakSelf.newsFeed = feed;
        [[VOAppContext sharedInstance].profilePictureStore downloadProfilePicturesForNewsFeed:feed];
        [weakSelf.tableView reloadData];
        [weakSelf.refreshControl endRefreshing];
    };
    [[VOAppContext sharedInstance].feedStore fetchNewsFeedWithRequest:request
                                                                block:requestBlock];
}


- (void)refreshTableWithDelta:(NSInteger)delta {
    
    NSInteger count = [self.newsFeed.posts count];
    NSInteger oldCount = count - delta;
    
    // Get the indexpath of the load cell in the table view
    NSIndexPath *loadCellIndexPath = [NSIndexPath indexPathForItem:oldCount inSection:0];
    
    // Setup an array of index paths to insert into the table view.
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

    // NOTE: Count is being offset by 1 to account for the addition
    // of the new load cell at the end of the table view.
    for (NSInteger i = oldCount; i < (count + 1); ++i) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    [self.tableView beginUpdates];

    // Delete the load cell at the end of the table view.
    [self.tableView deleteRowsAtIndexPaths:@[loadCellIndexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    // Add the new index paths.
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView endUpdates];
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
