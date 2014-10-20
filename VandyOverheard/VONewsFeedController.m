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
#import "VOFeedStoreDelegate.h"
#import "VONewsFeedLoadCell.h"
#import "VONewsFeedPostCell.h"
#import "VOPost.h"
#import "VOProfilePictureStore.h"

@interface VONewsFeedController () <UITableViewDataSource, UITableViewDelegate, VOFeedStoreDelegate>

/**
 * @abstract
 *  A hash table for cells displayed in the table view.
 */
@property (nonatomic, strong) NSMutableDictionary *cellHeightHash;

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
    self.cellHeightHash = [[NSMutableDictionary alloc] init];
    
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
    
    // TODO: Better to use Notification Center
    // than delegation if this object
    // is globally accessible.
    [VOAppContext sharedInstance].feedStore.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated {
    [[VOAppContext sharedInstance].feedStore fetchFirstPage];
}


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    VOFeedStore *feedStore = [VOAppContext sharedInstance].feedStore;
    
    if (indexPath.row == [feedStore count]) {
        // This is the last cell in the table view.
        VONewsFeedLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellId
                                                                   forIndexPath:indexPath];

        [cell startAnimating];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Whenever the load cell is reached in the table view,
        // that means it is time to load more items into the
        // news feed. Load cell is at the end of the table view.

        [feedStore fetchNextPage];
        
        // Force the cell to perform the
        [cell layoutIfNeeded];
        self.cellHeightHash[indexPath] = @(CGRectGetHeight(cell.frame));
        
        return cell;
    }
    else {
        VONewsFeedPostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellId
                                                                   forIndexPath:indexPath];
        
        cell.post = feedStore.posts[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    VOFeedStore *feedStore = [VOAppContext sharedInstance].feedStore;
    if ([feedStore count] == 0) {
        return 0;
    }
    else {
        // Add the load cell.
        return [feedStore count] + 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellHeightHash[indexPath]) {
        [self.cellHeightHash[indexPath] integerValue];
    }
    // Better approximation needed here.
    return 44.f;
}


#pragma mark - Refreshing UITableView

- (void)refreshControlValueDidChange {
    [[VOAppContext sharedInstance].feedStore fetchNextPage];
}


- (void)refreshTableWithDelta:(NSInteger)delta {
    
    VOFeedStore *feedStore = [VOAppContext sharedInstance].feedStore;
    NSInteger count = [feedStore count];
    NSInteger oldCount = count - delta;
    
    if (count <= oldCount) {
        // No new data was added, don't do anything.
        return;
    }

    // Setup an array of index paths to insert into the table view.
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

    for (NSInteger i = oldCount; i < count; ++i) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    // [self.tableView beginUpdates];

    // Add the new index paths.
    [self.tableView insertRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationNone];
    
    // [self.tableView endUpdates];
}


#pragma mark - VOFeedStoreDelegate Methods

- (void)feedStore:(VOFeedStore *)store failedWithError:(NSError *)error {
#warning Handle error!
}


- (void)feedStore:(VOFeedStore *)store didUpdateWithDelta:(NSInteger)delta {

    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }

    [[VOAppContext sharedInstance].profilePictureStore downloadProfilePicturesForPosts:store.posts];

    // TODO: Better way to do this.
    
    // If the number of posts is less than or equal to
    // the number of posts fetched per network call, then
    // just refresh the entire table view.
    if (store.networkLimit >= [store count]) {
        [self.tableView reloadData];
    }
    else {
        [self refreshTableWithDelta:delta];
    }
    
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
