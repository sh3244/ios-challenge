//
//  EmployeeListViewController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "EmployeeListViewController.h"
#import "ShoppingCartViewController.h"
#import "NavigationController.h"

#import "LoginManager.h"
#import "APIManager.h"

#import "UserTableViewCell.h"

#import "User.h"

@interface EmployeeListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<User *> *users;

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"Employee List";

  [self setupModalStyle];

  [self setupTableView];

  [self setupSearchBar];

  [self setupNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self update];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_tableView fillSuperview];
}

- (void)logOut {
  [[LoginManager sharedManager] performLogOut];
  [self dismissViewControllerAnimated:true completion:nil];
}

- (void)launchCart {
  [self dismissViewControllerAnimated:true completion:^{
    [_delegate launchViewController:NSStringFromClass([ShoppingCartViewController class])];
  }];
}

- (void)update {
  [_users removeAllObjects];
  [[APIManager sharedManager] fetchRealmUsersWithCompletion:^(NSArray<User *> *users) {
    _users = users.mutableCopy;
    [_tableView reloadData];
  }];
}

#pragma mark - Search + Table

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
  [refreshControl endRefreshing];
}

- (void)setupSearchBar {
  _searchBar = [UISearchBar new];
  [self.view addSubview:_searchBar];
  _searchBar.barStyle = UISearchBarStyleMinimal;
  _searchBar.tintColor = [UIColor whiteColor];
  _searchBar.delegate = self;
  [_searchBar setPlaceholder:@"search employees..."];
}

- (void)setupTableView {
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
  [_tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
}

- (void)setupNavigationBar {
  UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
  UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:self action:@selector(launchCart)];
  self.navigationItem.leftBarButtonItems = @[logOutButton, cartButton];

  UIBarButtonItem *viewCartButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissFromButton)];
  self.navigationItem.rightBarButtonItem = viewCartButton;
}

#pragma mark - UITableView Datasource

- (void)tableView:(UITableView *)tableView willDisplayCell:(UserTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  // TableView hidden :)
  if (_tableView.alpha == 0) {
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                       _tableView.alpha = 1;
                     } completion:nil];
  }

  User *user = [_users objectAtIndex:indexPath.row];
  [cell.userFirstNameLabel setText:user.firstName];
  [cell.userLastNameLabel setText:user.lastName];
  [cell.userEmailLabel setText:user.email];
  [cell.userDateLabel setText:@"Hired on Date"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserTableViewCell class]) forIndexPath:indexPath];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
  return 90;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _users.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

@end
