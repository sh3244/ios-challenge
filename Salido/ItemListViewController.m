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

#import "APIManager.h"
#import "LoginManager.h"
#import "AlertManager.h"

#import "Item.h"

@interface ItemListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ItemTableViewCellDelegate, TransitionViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<Item *> *items;

@property (nonatomic, strong) NSMutableArray<NSIndexPath *> *selectedPaths;

@property (nonatomic, strong) NSString *searchString;

@property (nonatomic, assign) BOOL firstLaunch;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Wine.com API";
  _searchString = @"";
  _firstLaunch = YES;

  [self setupSearchBar];

  [self setupTableView];

  [self setupNavigationBar];

  _selectedPaths = [NSMutableArray new];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (![[LoginManager sharedManager] currentlyLoggedIn]) {
    [self launchLoginViewController];
  } else if (_firstLaunch){
    NSString *name = [[LoginManager sharedManager] currentUserName];

    [[AlertManager sharedManager] showGoodAlertWithMessage:[@"Welcome..." stringByAppendingString:name]];

    [[APIManager sharedManager] fetchCatalogItemsWith:@"wine" completion:^(NSArray<Item *> *items) {
      self.items = items.mutableCopy;
      [_tableView reloadData];
    }];

    _firstLaunch = NO;
  }
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_searchBar anchorTopCenterFillingWidthWithLeftAndRightPadding:0 topPadding:0 height:40];
  [_tableView alignUnder:_searchBar matchingLeftAndRightFillingHeightWithTopPadding:0 bottomPadding:0];
}

- (void (^)(void))itemCellActionButtonPressedWithValue:(NSInteger)value atIndex:(NSInteger)index {
  if ([[LoginManager sharedManager] currentUser]) {
      User *user = [[LoginManager sharedManager] currentUser];
    [[APIManager sharedManager] updateRealmWith:[_items objectAtIndex:index] forUser:user withCount:value];
  }
  return ^{

  };
}

- (void)launchViewController:(NSString *)viewControllerName {
  Class class = NSClassFromString(viewControllerName);
  UIViewController *controller = [[class alloc] init];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:controller];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
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
  [_searchBar setPlaceholder:@"search wine.com, ex. \"2014\" or \"merlot\"..."];
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
  [_tableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ItemTableViewCell class])];
}

- (void)setupNavigationBar {
  UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
  UIBarButtonItem *employeeListButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(launchEmployeeListViewController)];

  self.navigationItem.leftBarButtonItems = @[logOutButton, employeeListButton];

  UIBarButtonItem *viewCartButton = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:self action:@selector(launchShoppingCartViewController)];
  self.navigationItem.rightBarButtonItem = viewCartButton;
}

#pragma mark - UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [_searchBar resignFirstResponder];
  if (searchBar.text.length > 0) {
    _searchString = searchBar.text;
    [UIView animateWithDuration:1 animations:^{
      _tableView.alpha = 0;
    } completion:^(BOOL finished) {
      [[APIManager sharedManager] fetchCatalogItemsWith:searchBar.text completion:^(NSArray<Item *> *items) {
        self.items = items.mutableCopy;
        [_tableView reloadData];
      }];
    }];
  }
}

#pragma mark - UITableView Datasource

- (void)tableView:(UITableView *)tableView willDisplayCell:(ItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  // TableView hidden :)
  if (_tableView.alpha == 0) {
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                       _tableView.alpha = 1;
                     } completion:nil];
  }

  Item *item = [_items objectAtIndex:indexPath.row];
  if (!item) {
    return;
  }

  // Setup cell
  cell.index = indexPath.row;
  cell.delegate = self;
  [cell.itemNameLabel setText:item.name];
  [cell.minPriceLabel setText:[NSString stringWithFormat:@"$%.02f", @(item.minPrice).floatValue]];
  [cell.itemTypeLabel setText:[NSString stringWithFormat:@"Kind: %@", item.type]];
  [cell.vintageLabel setText:[NSString stringWithFormat:@"Year: %@", item.vintage]];
  [cell.actionButton setTitle:@"+" forState:UIControlStateNormal];
  cell.countField.delegate = self;

  NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:item.url];
  [str addAttribute: NSLinkAttributeName value: item.url range: NSMakeRange(0, str.length)];

  [cell.urlLabel setAttributedText:str];

  ItemImage *image = item.images.firstObject;
  NSString *imageURL = image.imageURL;
  dispatch_async(dispatch_get_global_queue(0,0), ^{
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
    if (data == nil)
      return;
    dispatch_async(dispatch_get_main_queue(), ^{
      [cell.itemImageView setImage:[UIImage imageWithData: data]];
    });
  });
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
    return 210;
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

#pragma mark - Lifecycle

- (void)launchLoginViewController {
  LoginViewController *loginController = [LoginViewController new];
  NavigationController *navController = [[NavigationController new] initWithRootViewController:loginController];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchEmployeeListViewController {
  EmployeeListViewController *controller = [EmployeeListViewController new];
  controller.delegate = self;
  NavigationController *navController = [[NavigationController new] initWithRootViewController:controller];
  [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)launchShoppingCartViewController {
  ShoppingCartViewController *controller = [ShoppingCartViewController new];
  controller.delegate = self;
  NavigationController *navController = [[NavigationController new] initWithRootViewController:controller];
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
