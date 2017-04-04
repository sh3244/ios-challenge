//
//  LoginViewController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPinView.h"
#import "RegisterPinView.h"
#import <Facade/UIView+Facade.h>

#import "ItemListViewController.h"

#import "LoginManager.h"

@interface LoginViewController () <LoginPinDelegate, RegisterPinDelegate>

@property (nonatomic, strong) LoginPinView *loginPinView;
@property (nonatomic, strong) RegisterPinView *registerPinView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Login";

  _loginPinView = [LoginPinView new];
  [self.view addSubview:_loginPinView];
  _loginPinView.delegate = self;

  _registerPinView = [RegisterPinView new];
  [self.view addSubview:_registerPinView];
  _registerPinView.nameField.delegate = self;
  _registerPinView.alpha = 0;
  _registerPinView.delegate = self;
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [_loginPinView anchorInCenterFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
  [_registerPinView anchorInCenterFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
}

#pragma mark - LoginPinDelegate

- (void)userLoggedIn {
  UINavigationController *navigationController = [self navigationController];

  ItemListViewController *controller = [ItemListViewController new];
  [navigationController pushViewController:controller animated:YES];
}

- (void)didEnterPin:(NSString *)pin {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedIn) name:@"LoginManagerLoggedIn" object:nil];

  [_loginPinView resetPinCode];

  [[LoginManager sharedManager] performLoginWithPin:pin completion:^{
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
}

- (void)didSelectRegister {
  [UIView animateWithDuration:1 animations:^{
    _loginPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:1 animations:^{
      _registerPinView.alpha = 1;
    }];
  }];
}

// TODO
- (void)didSelectForgotPin {

}

#pragma mark - RegisterPinDelegate

- (void)registerWithName:(NSString *)name withPin:(NSString *)pin {
  [[LoginManager sharedManager] registerUserWithName:name withPin:pin];

  [UIView animateWithDuration:1 animations:^{
    _registerPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:1 animations:^{
      _loginPinView.alpha = 1;
    }];
  }];
}

@end
