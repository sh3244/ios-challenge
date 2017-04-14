//
//  ShoppingCartViewController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "OrderViewController.h"

#import "APIManager.h"
#import "LoginManager.h"

#import "ItemTableViewCell.h"

#import "Item.h"

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Button *checkoutButton;

@property (nonatomic, strong) NSMutableArray<Item *> *items;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Shopping Cart";

  [self setupModalStyle];

  [self setupTableView];

  [self setupSearchBar];

  [self setupNavigationBar];
  _items = [NSMutableArray new];
  _checkoutButton = [Button new];
  [_checkoutButton setBackgroundColor:[UIColor darkGrayColor]];
  [_checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
  _checkoutButton.enabled = NO;
  [self.view addSubview:_checkoutButton];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self update];
  [_tableView reloadData];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [_tableView anchorTopCenterFillingWidthWithLeftAndRightPadding:0 topPadding:0 height:600];
  [_checkoutButton alignUnder:_tableView centeredFillingWidthAndHeightWithLeftAndRightPadding:0 topAndBottomPadding:0];
}

- (void)logOut {
  [[LoginManager sharedManager] performLogOut];
  [self dismissViewControllerAnimated:true completion:nil];
}

- (void)checkout {
  [self dismissViewControllerAnimated:true completion:^{
    [_delegate launchViewController:NSStringFromClass([OrderViewController class])];
  }];
}

#pragma mark - Search + Table

- (void)update {
  [_items removeAllObjects];
  User *user = [[LoginManager sharedManager] currentUser];
  [[APIManager sharedManager] fetchRealmCartForUser:user completion:^(NSArray<Item *> *items) {
    _items = items.mutableCopy;
  }];
}

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
  [self update];
  _tableView.alpha = 0;
  [_tableView reloadData];
  [refreshControl endRefreshing];
}

- (void)setupSearchBar {
  _searchBar = [UISearchBar new];
  [self.view addSubview:_searchBar];
  _searchBar.barStyle = UISearchBarStyleMinimal;
  _searchBar.tintColor = [UIColor whiteColor];
  _searchBar.delegate = self;
  [_searchBar setPlaceholder:@"search wine api, ex. \"2014\" or \"merlot\"..."];
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
  UIBarButtonItem *viewCartButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissFromButton)];
  self.navigationItem.leftBarButtonItem = logOutButton;
  self.navigationItem.rightBarButtonItem = viewCartButton;
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
                       _checkoutButton.enabled = YES;
                       [_checkoutButton setBackgroundColor:[UIColor greenColor]];
                     } completion:nil];
  }

  Item *item = [_items objectAtIndex:indexPath.row];

  // Setup cell
  cell.countField.alpha = 0;
  [cell.itemNameLabel setText:item.name];
  [cell.minPriceLabel setText:[NSString stringWithFormat:@"$%.02f", @(item.minPrice).floatValue]];
  [cell.itemTypeLabel setText:[NSString stringWithFormat:@"Kind: %@", item.type]];
  [cell.vintageLabel setText:[NSString stringWithFormat:@"Year: %@", item.vintage]];
  [cell.actionButton setTitle:@(item.count).stringValue forState:UIControlStateNormal];
  cell.actionButton.userInteractionEnabled = false;

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

}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
  return 90;
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

@end
