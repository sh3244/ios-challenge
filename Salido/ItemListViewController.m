//
//  ItemListViewController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemListViewController.h"
#import "LoginViewController.h"
#import "NavigationController.h"
#import "ItemDetailViewController.h"
#import "ShoppingCartViewController.h"
#import "EmployeeListViewController.h"

#import <Facade/UIView+Facade.h>

#import "APIManager.h"
#import <Realm/Realm.h>
#import "LoginManager.h"

#import "CatalogRequestModel.h"
#import "CatalogResponseModel.h"
#import "CatalogModel.h"
#import "ItemModel.h"

#import "Item.h"

@interface ItemListViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults<Item *> *items;

@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *selectedPaths;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Main";

  _tableView = [UITableView new];
  [self.view addSubview:_tableView];
  _tableView.backgroundColor = [UIColor blackColor];
  _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);

  UIRefreshControl *refreshControl = [UIRefreshControl new];
  [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
  [_tableView addSubview:refreshControl];
  [_tableView sendSubviewToBack:refreshControl];

  _tableView.delegate = self;
  _tableView.dataSource = self;
  [_tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ItemTableViewCell class])];
  [_tableView fillSuperview];

  UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchSettings)];
  self.navigationItem.leftBarButtonItem = settingsButtonItem;

  _selectedPaths = [NSMutableArray new];

  [self update];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

//  if (![[LoginManager sharedManager] isLoggedIn]) {
//    [self launchLoginViewController];
//  } else {
//    [self update];
//  }
  [_selectedPaths removeAllObjects];
}

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
  [refreshControl endRefreshing];
  [self update];
}

#pragma mark - Launch

- (void)launchSettings {
  UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];

  [actionSheet addAction:[UIAlertAction actionWithTitle:@"View Cart" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self launchShoppingCartViewController];
  }]];

  [actionSheet addAction:[UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    [self logOut];
  }]];

  [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

  }]];

  [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)launchLoginViewController {
  LoginViewController *loginController = [LoginViewController new];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:loginController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchEmployeeListViewController {
  EmployeeListViewController *loginController = [EmployeeListViewController new];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:loginController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchShoppingCartViewController {
  ShoppingCartViewController *loginController = [ShoppingCartViewController new];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:loginController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchItemDetailViewControllerWithItem:(Item *)item {
  ItemDetailViewController *detailController = [[ItemDetailViewController alloc] initWithItem:item];
  NavigationController *navController = [[NavigationController new] initWithRootViewController: detailController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)logOut {
  [[LoginManager sharedManager] performLogOut];
  if (![[LoginManager sharedManager] currentlyLoggedIn]) {
    [self launchLoginViewController];
  }
}

#pragma mark - Data

- (void)update {
  CatalogRequestModel *requestModel = [CatalogRequestModel new];
  [[APIManager sharedManager] getItemsWithRequestModel:requestModel
                                               success:^(CatalogResponseModel *responseModel){
                                                 [self updateRealm:responseModel];
                                               } failure:^(NSError *error) {

                                               }];
}

- (void)updateRealm:(CatalogResponseModel *)responseModel {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    @autoreleasepool {
      RLMRealm *realm = [RLMRealm defaultRealm];
      [realm beginWriteTransaction];
      [realm deleteAllObjects];
      [realm commitWriteTransaction];

      [realm beginWriteTransaction];
      for(ItemModel *item in responseModel.items){
        Item *itemRealm = [[Item alloc] initWithMantleModel:item];
        [realm addObject:itemRealm];
      }
      [realm commitWriteTransaction];
      dispatch_async(dispatch_get_main_queue(), ^{
        RLMResults *items = [Item allObjectsInRealm:[RLMRealm defaultRealm]];
        _items = items;
        [self.tableView reloadData];
      });
    }
  });
}

- (void)fetchRealm {
  dispatch_async(dispatch_get_main_queue(), ^{
    RLMResults *items = [Item allObjectsInRealm:[RLMRealm defaultRealm]];
    _items = items;
    [self.tableView reloadData];
  });
}

#pragma mark - UITableView Datasource

- (void)tableView:(UITableView *)tableView willDisplayCell:(ItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  Item *item = [_items objectAtIndex:indexPath.row];
  [cell setupWithName:item.name withType:item.type withItem:item];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ItemTableViewCell class]) forIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  if ([_selectedPaths containsObject:indexPath]) {
    [self launchItemDetailViewControllerWithItem:[_items objectAtIndex:indexPath.row]];
  }

  [tableView beginUpdates];
  [_selectedPaths addObject:indexPath];
  [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([_selectedPaths containsObject:indexPath]) {
    [_selectedPaths removeObject:indexPath];
  }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
  if ([_selectedPaths containsObject:indexPath]) {
    return 240;
  } else {
    return 90;
  }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

@end
