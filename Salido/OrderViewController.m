//
//  OrderViewController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "OrderViewController.h"

#import "LoginManager.h"
#import "APIManager.h"

@interface OrderViewController ()

@property (nonatomic, strong) Button *orderAgainButton;
@property (nonatomic, strong) Label *thankYouLabel;

@end

@implementation OrderViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupNavigationBar];
  _orderAgainButton = [Button new];
  [_orderAgainButton setTitle:@"Start New Order" forState:UIControlStateNormal];
  [_orderAgainButton setBackgroundColor:[UIColor blueColor]];
  [_orderAgainButton addTarget:self action:@selector(dismissFromButton) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_orderAgainButton];

  _thankYouLabel = [Label new];
  [_thankYouLabel setText:@"Thank You! Order Complete!"];
  [self.view addSubview:_thankYouLabel];
}

- (void)viewWillLayoutSubviews {
  [_thankYouLabel anchorTopCenterFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:600];
  [_orderAgainButton alignUnder:_thankYouLabel centeredFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
}

- (void)viewDidAppear:(BOOL)animated {
  [[APIManager sharedManager] checkoutRealmCartForUser:[[LoginManager sharedManager] currentUser]];
}

- (void)logOut {
  [[LoginManager sharedManager] performLogOut];
  [self dismissViewControllerAnimated:true completion:nil];
}

- (void)setupNavigationBar {
  UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
  self.navigationItem.leftBarButtonItems = @[logOutButton];

  UIBarButtonItem *viewCartButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissFromButton)];
  self.navigationItem.rightBarButtonItem = viewCartButton;
}

@end
