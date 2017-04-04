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

#import <Facade/UIView+Facade.h>

#import "APIManager.h"
#import <Realm/Realm.h>
#import "LoginManager.h"

#import "CatalogRequestModel.h"
#import "CatalogResponseModel.h"
#import "CatalogModel.h"
#import "ItemModel.h"

#import "Item.h"

@interface ItemListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, nullable) RLMResults<Item *> *items;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Main";

  _tableView = [UITableView new];
  [self.view addSubview:_tableView];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [_tableView fillSuperview];

  [self update];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if (![[LoginManager sharedManager] isLoggedIn]) {
    [self launchLoginViewController];
  }
}

- (void)update {
  CatalogRequestModel *requestModel = [CatalogRequestModel new];
  [[APIManager sharedManager] getItemsWithRequestModel:requestModel
                                               success:^(CatalogResponseModel *responseModel){

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
                                                       RLMRealm *realmMainThread = [RLMRealm defaultRealm];
                                                       RLMResults *items = [Item allObjectsInRealm:realmMainThread];
                                                       self.items = items;
                                                       [self.tableView reloadData];
                                                     });
                                                   }
                                                 });

                                               } failure:^(NSError *error) {
                                                 self.items = [Item allObjects];
                                                 [self.tableView reloadData];
                                               }];

}

- (void)launchLoginViewController {
  LoginViewController *loginController = [LoginViewController new];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:loginController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchItemDetailViewControllerWithItem:(Item *)item {
  ItemDetailViewController *detailController = [[ItemDetailViewController alloc] initWithItem:item];
  NavigationController *navController = [[NavigationController new] initWithRootViewController: detailController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [UITableViewCell new];
  [cell.textLabel setText:_items[indexPath.row].name];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self launchItemDetailViewControllerWithItem:_items[indexPath.row]];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

@end
