//
//  AppDelegate.m
//  VandyOverheard
//
//  Created by Brendan McNamra on 9/26/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>

#import "VOAppContext.h"
#import "VOAppContextFactory.h"
#import "VODesignFactory.h"
#import "VOLoginFlowController.h"
#import "VONewsFeedController.h"

@interface AppDelegate () <VOLoginFlowDelegate, VOAppContextFactory>

#pragma mark - Private Properties

/**
 * @abstract
 *  The current user of the application.
 *  This will be nil if there is no current user.
 */
@property (nonatomic, strong) VOUser *currentUser;

/**
 * @abstract
 *  Perform any needed setup operations during launch.
 */
- (void)setUp;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self setUp];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    VOLoginFlowController *rootController = [[VOLoginFlowController alloc] init];

    VONewsFeedController *newsFeedController = [[VONewsFeedController alloc] init];
    rootController.delegate = self;
    rootController.destinationController =
        [[UINavigationController alloc] initWithRootViewController: newsFeedController];

    self.window.rootViewController = rootController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - SetUp

- (void)setUp {
    [[UINavigationBar appearance] setBarTintColor:[VODesignFactory navBarColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName: [VODesignFactory navBarTextColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
}


#pragma mark - VOLoginFlowDelegate Methods

- (void)loginFlowController:(VOLoginFlowController *)controller
           didLoginWithUser:(VOUser *)user {

    self.currentUser = user;
    // When the user is logged in, configure
    // the AppContext.
    [VOAppContext resetContextWithFactory:self];
}


#pragma mark - VOAppContextFactory Methods

- (VOUser *)createCurrentUser {
    return self.currentUser;
}


@end
