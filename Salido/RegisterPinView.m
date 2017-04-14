//
//  RegisterView.m
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "RegisterPinView.h"
#import "AlertManager.h"
#import "StringManager.h"

@interface RegisterPinView()

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
@property (nonatomic, strong) Button *clearButton;

@property (nonatomic, strong) NSArray<Button *> *pinButtonArray;
@property (nonatomic, strong) View *pinView;

@property (nonatomic, strong) Label *pinLabel;
@property (nonatomic, strong) Button *registerButton;

@property (nonatomic, strong) NSString *pinDisplayCode;

@end

@implementation RegisterPinView

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
    [obj setShowsTouchWhenHighlighted:YES];
    [obj addTarget:self action:@selector(pinButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  }];

  [self addSubview:_pinView];

  _pinDisplayCode = @"******";
  _pinLabel = [Label new];
  [_pinLabel setText:_pinDisplayCode];
  _pinLabel.textAlignment = NSTextAlignmentCenter;
  _pinLabel.font = [UIFont boldSystemFontOfSize:48];
  [self addSubview:_pinLabel];

  _firstNameField = [TextField new];
  _firstNameField.placeholder = @"first name";
  [self addSubview:_firstNameField];

  _lastNameField = [TextField new];
  _lastNameField.placeholder = @"last name";
  [self addSubview:_lastNameField];

  _emailField = [TextField new];
  _emailField.placeholder = @"email";
  [self addSubview:_emailField];

  _registerButton = [Button new];
  [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
  [_registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_registerButton];

  return self;
}

- (void)layoutSubviews {
  [_firstNameField anchorTopCenterFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:40];
  [_lastNameField alignUnder:_firstNameField centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:40];
  [_emailField alignUnder:_lastNameField centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:40];
  [_pinLabel alignUnder:_emailField centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
  [_registerButton anchorBottomCenterFillingWidthWithLeftAndRightPadding:10 bottomPadding:10 height:80];

  [_pinView alignUnder:_pinLabel centeredFillingWidthWithLeftAndRightPadding:80 topPadding:10 height:360];
  [_pinView groupGrid:[_pinButtonArray subarrayWithRange:NSMakeRange(1, 9)] fillingWidthWithColumnCount:3 spacing:10];
  [_button0 alignUnder:_button8 matchingCenterWithTopPadding:10 width:_button8.width height:_button8.height];
}

# pragma mark - View Model

- (void)pinButtonPressed:(Button *)sender {
  _pinDisplayCode = [[StringManager sharedManager] updatePin:_pinDisplayCode withSingleValue:sender.titleLabel.text];
  [self updatePinCode];
}

- (BOOL)inputIsValid {
  __weak StringManager *manager = [StringManager sharedManager];
  if ([manager validatePin:_pinDisplayCode]) {
    if ([manager validateName:_firstNameField.text]) {
      if ([manager validateName:_lastNameField.text]) {
        if ([manager validateEmail:_emailField.text]) {

        }
        return YES;
      }
    }
  }
  return NO;
}

- (void)warnValidation {
  [[AlertManager sharedManager] showAlertWithMessage:@"Please register with a 6 digit pin, first name, and last name..."];
}

- (void)showSuccess {
  [[AlertManager sharedManager] showGoodAlertWithMessage:@"Registered!"];
}

- (void)updatePinCode {
  [_pinLabel setText:_pinDisplayCode];
}

- (void)reset {
  [_firstNameField setText:@""];
  [_lastNameField setText:@""];
  [_emailField setText:@""];
  [_pinLabel setText:@""];
}

#pragma mark - RegisterPinDelegate

- (void)registerButtonPressed:(Button *)sender {
  if ([self inputIsValid]) {
    if ([[StringManager sharedManager] validateEmail:_emailField.text]) {
    [_delegate registerWithFirstName:_firstNameField.text lastName:_lastNameField.text withPin:_pinDisplayCode withEmail:_emailField.text];
    }
    [_delegate registerWithFirstName:_firstNameField.text lastName:_lastNameField.text withPin:_pinDisplayCode withEmail:@""];
    [self reset];
    return;
  }

  [self reset];
  [self warnValidation];
}

@end
