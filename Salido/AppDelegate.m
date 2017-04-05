//
//  AppDelegate.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemListViewController.h"
#import "NavigationController.h"

#import <Realm/Realm.h>

#import <FLEX/FLEXManager.h>

@interface AppDelegate ()

@property (nonatomic, strong) ItemListViewController *mainViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [[FLEXManager sharedManager] showExplorer];

  self.mainViewController = [[ItemListViewController alloc] init];

  self.window.backgroundColor = [UIColor darkGrayColor];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  UINavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:self.mainViewController];
  self.window.rootViewController = navigationController;
  [self.window makeKeyAndVisible];

  // Delete Realm Database
  [[NSFileManager defaultManager] removeItemAtURL:[RLMRealmConfiguration defaultConfiguration].fileURL error:nil];

  return YES;
}

@end
