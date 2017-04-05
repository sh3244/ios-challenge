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

#import <Realm/Realm.h>
#import "APIManager.h"
#import "LoginManager.h"

#import "CatalogRequestModel.h"
#import "CatalogResponseModel.h"
#import "CatalogModel.h"
#import "ItemModel.h"

#import "Item.h"

#import "Constant.h"

#import <CRToast/CRToast.h>

@interface ItemListViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults<Item *> *items;

@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *selectedPaths;

@property (nonatomic, strong) NSString *searchString;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Main";
  _searchString = @"high";

  _searchBar = [UISearchBar new];
  [self.view addSubview:_searchBar];
  _searchBar.barStyle = UISearchBarStyleMinimal;
  _searchBar.tintColor = [UIColor whiteColor];
  _searchBar.delegate = self;
  [_searchBar setText:@"high"];

  _tableView = [UITableView new];
  [self.view addSubview:_tableView];
  _tableView.backgroundColor = [UIColor blackColor];
  _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
  _tableView.alpha = 0;

  UIRefreshControl *refreshControl = [UIRefreshControl new];
  [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
  [_tableView addSubview:refreshControl];
  [_tableView sendSubviewToBack:refreshControl];

  _tableView.delegate = self;
  _tableView.dataSource = self;
  [_tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ItemTableViewCell class])];

  UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchSettings)];
  self.navigationItem.leftBarButtonItem = settingsButtonItem;

  _selectedPaths = [NSMutableArray new];

  [self update];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_searchBar anchorTopCenterFillingWidthWithLeftAndRightPadding:0 topPadding:0 height:40];
  [_tableView alignUnder:_searchBar matchingLeftAndRightFillingHeightWithTopPadding:0 bottomPadding:0];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if (![[LoginManager sharedManager] currentlyLoggedIn]) {
    [self launchLoginViewController];
  } else {
    [self update];
  }

  NSDictionary *options = @{
                            kCRToastTextKey : @"Welcome!",
                            kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                            kCRToastBackgroundColorKey : [UIColor greenColor],
                            kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                            kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                            kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                            kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                            };
  [CRToastManager showNotificationWithOptions:options
                              completionBlock:^{

                              }];
  [_selectedPaths removeAllObjects];
}

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
  [refreshControl endRefreshing];
  [self update];
}

#pragma mark - UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  if (searchBar.text.length > 0) {
    _searchString = searchBar.text;
    [self update];
  }
}

#pragma mark - UITableView Datasource

- (void)tableView:(UITableView *)tableView willDisplayCell:(ItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  Item *item = [_items objectAtIndex:indexPath.row];
  [cell setupWithItem:item];
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

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
  if ([_selectedPaths containsObject:indexPath]) {
    return 250;
  } else {
    return 90;
  }
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

#pragma mark - Data

- (void)update {
  CatalogRequestModel *requestModel = [CatalogRequestModel new];
  requestModel.offset = 0;
  requestModel.size = @(20).integerValue;
  requestModel.search = _searchString;
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
      [self fetchRealm];
    }
  });
}

- (void)fetchRealm {
  dispatch_async(dispatch_get_main_queue(), ^{
    RLMResults *items = [Item allObjectsInRealm:[RLMRealm defaultRealm]];
    _items = items;
    [_tableView reloadData];
    if (_tableView.alpha != 1) {
      [UIView animateWithDuration:base_duration animations:^{
        _tableView.alpha = 1;
      }];
    }
  });
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

@end
