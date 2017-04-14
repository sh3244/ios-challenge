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
#import "ForgotPinView.h"
#import <Facade/UIView+Facade.h>

#import "ItemListViewController.h"

#import "LoginManager.h"
#import "APIManager.h"
#import "AlertManager.h"

@interface LoginViewController () <LoginPinDelegate, RegisterPinDelegate, ForgotPinDelegate>

@property (nonatomic, strong) LoginPinView *loginPinView;
@property (nonatomic, strong) RegisterPinView *registerPinView;
@property (nonatomic, strong) ForgotPinView *forgotPinView;

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
  _registerPinView.firstNameField.delegate = self;
  _registerPinView.lastNameField.delegate = self;
  _registerPinView.emailField.delegate = self;

  _registerPinView.alpha = 0;
  _registerPinView.delegate = self;

  _forgotPinView = [ForgotPinView new];
  _forgotPinView.alpha = 0;
  _forgotPinView.delegate = self;
  [self.view addSubview:_forgotPinView];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  [_loginPinView anchorInCenterFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
  [_registerPinView anchorInCenterFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
  [_forgotPinView anchorInCenterFillingWidthAndHeightWithLeftAndRightPadding:10 topAndBottomPadding:10];
}

- (void)didSelectRegister {
  [UIView animateWithDuration:0.5 animations:^{
    _loginPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
      _registerPinView.alpha = 1;
    }];
  }];
}

- (void)didSelectForgotPin {
  [UIView animateWithDuration:0.5 animations:^{
    _loginPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
      _forgotPinView.alpha = 1;
    }];
  }];
}


#pragma mark - LoginPinDelegate

- (void)didEnterPin:(NSString *)pin {
  [_loginPinView resetPinCode];
  [[LoginManager sharedManager] performLoginWithPin:pin completion:^{
    [self dismissViewControllerAnimated:YES completion:nil];
  }];

  if (![[LoginManager sharedManager] currentlyLoggedIn]) {
    [_loginPinView warnValidation];
  }
}

#pragma mark - RegisterPinDelegate

- (void)registerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName withPin:(NSString *)pin withEmail:(NSString *)email {
  User *user = [[User alloc] initWithFirstName:firstName lastName:lastName pin:pin email:email];
  if ([[LoginManager sharedManager] canRegisterUser:user]) {
    [[LoginManager sharedManager] registerUser:user];
  }
  else {
    // Pin, email, or last name are not cool...
    [[AlertManager sharedManager] showAlertWithMessage:@"Registration failed..."];
  }

  [UIView animateWithDuration:1 animations:^{
    _registerPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:1 animations:^{
      _loginPinView.alpha = 1;
    }];
  }];
}

#pragma mark - ForgotPinDelegate

- (void)findPinWithEmail:(NSString *)email {
  [[APIManager sharedManager] fetchRealmUsersWithCompletion:^(NSArray<User *> *users) {
    for (User *user in users) {
      if ([user.email isEqualToString:email]) {
        NSString *message = @"Found pin by email. Pin:";
        [[AlertManager sharedManager] showGoodAlertWithMessage:[message stringByAppendingString:user.pin]];
      }
      else {
        [[AlertManager sharedManager] showAlertWithMessage:@"Email not found!"];
      }
    }
  }];

  [UIView animateWithDuration:1 animations:^{
    _forgotPinView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:1 animations:^{
      _loginPinView.alpha = 1;
    }];
  }];
}

@end
