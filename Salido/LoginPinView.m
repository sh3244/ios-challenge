//
//  LoginPinView.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "LoginPinView.h"
#import "AlertManager.h"
#import "StringManager.h"

@interface LoginPinView()

@property (nonatomic, strong) Button *button1;
@property (nonatomic, strong) Button *button2;
@property (nonatomic, strong) Button *button3;
@property (nonatomic, strong) Button *button4;
@property (nonatomic, strong) Button *button5;
@property (nonatomic, strong) Button *button6;
@property (nonatomic, strong) Button *button7;
@property (nonatomic, strong) Button *button8;
@property (nonatomic, strong) Button *button9;
@property (nonatomic, strong) Button *button0;

@property (nonatomic, strong) NSArray<Button *> *pinButtonArray;
@property (nonatomic, strong) View *pinView;

@property (nonatomic, strong) Label *pinLabel;
@property (nonatomic, strong) Button *registerButton;
@property (nonatomic, strong) Button *findButton;

@property (nonatomic, strong) NSString *pinDisplayCode;

@end

@implementation LoginPinView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  _button0 = [Button new];
  _button1 = [Button new];
  _button2 = [Button new];
  _button3 = [Button new];
  _button4 = [Button new];
  _button5 = [Button new];
  _button6 = [Button new];
  _button7 = [Button new];
  _button8 = [Button new];
  _button9 = [Button new];

  _pinButtonArray = @[
                                          _button0,
                                          _button1,
                                          _button2,
                                          _button3,
                                          _button4,
                                          _button5,
                                          _button6,
                                          _button7,
                                          _button8,
                                          _button9
                                          ];

  _pinView = [View new];

  [_pinButtonArray enumerateObjectsUsingBlock:^(Button * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [_pinView addSubview:obj];
    [obj setTitle:@(idx).stringValue forState:UIControlStateNormal];
    [obj addTarget:self action:@selector(pinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  }];

  [self addSubview:_pinView];

  _pinDisplayCode = @"******";
  _pinLabel = [Label new];
  _pinLabel.textAlignment = NSTextAlignmentCenter;
  _pinLabel.font = [UIFont boldSystemFontOfSize:48];
  [_pinLabel setText:_pinDisplayCode];

  _registerButton = [Button new];
  [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
  [_registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

  _findButton = [Button new];
  [_findButton setShowsTouchWhenHighlighted:YES];
  [_findButton setTitle:@"Find" forState:UIControlStateNormal];
  [_findButton addTarget:self action:@selector(forgotPinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:_pinLabel];
  [self addSubview:_registerButton];
  [self addSubview:_findButton];

  return self;
}

- (void)layoutSubviews {
  [_pinLabel anchorTopCenterFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];

  [_pinView alignUnder:_pinLabel centeredFillingWidthWithLeftAndRightPadding:80 topPadding:10 height:360];
  [_pinView groupGrid:[_pinButtonArray subarrayWithRange:NSMakeRange(1, 9)] fillingWidthWithColumnCount:3 spacing:10];
  [_button0 alignUnder:_button8 matchingCenterWithTopPadding:10 width:_button8.width height:_button8.height];

  [_findButton anchorBottomCenterFillingWidthWithLeftAndRightPadding:10 bottomPadding:10 height:80];
  [_registerButton alignAbove:_findButton fillingWidthWithLeftAndRightPadding:10 bottomPadding:10 height:80];
}

#pragma mark - LoginPinViewDelegate

- (void)registerButtonPressed:(Button *)sender {
  [self.delegate didSelectRegister];
}

- (void)forgotPinButtonPressed:(Button *)sender {
  [self.delegate didSelectForgotPin];
}

# pragma mark - View Model

- (void)pinButtonPressed:(Button *)sender {
  _pinDisplayCode = [[StringManager sharedManager] updatePin:_pinDisplayCode withSingleValue:sender.titleLabel.text];
  [_pinLabel setText:_pinDisplayCode];

  if ([self inputIsValid]) {
    [_delegate didEnterPin:_pinDisplayCode];
  }
}

- (BOOL)inputIsValid {
  if ([[StringManager sharedManager] validatePin:_pinDisplayCode]) {
    return YES;
  }
  return NO;
}

- (void)warnValidation {
  [[AlertManager sharedManager] showAlertWithMessage:@"Wrong Pin..."];
}

- (void)resetPinCode {
  [_pinLabel setText:@"******"];
  _pinDisplayCode = _pinLabel.text;
}

@end
