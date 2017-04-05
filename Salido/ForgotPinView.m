//
//  ForgotPinView.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ForgotPinView.h"

@interface ForgotPinView()

@property (nonatomic, strong) Label *pinLabel;
@property (nonatomic, strong) Button *registerButton;

@property (nonatomic, strong) NSString *pinDisplayCode;

@end

@implementation ForgotPinView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  _pinDisplayCode = @"******";
  _pinLabel = [Label new];
  [_pinLabel setText:_pinDisplayCode];
  [self addSubview:_pinLabel];

  _nameField = [TextField new];
  _nameField.placeholder = @"name";
  [self addSubview:_nameField];

  _registerButton = [Button new];
  [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
  [_registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_registerButton];

  return self;
}

- (void)layoutSubviews {
//  [_nameField anchorTopCenterFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
//  [_pinLabel alignUnder:_nameField centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
//  [_registerButton anchorBottomCenterFillingWidthWithLeftAndRightPadding:10 bottomPadding:10 height:80];
//
//  [_pinView alignUnder:_pinLabel centeredFillingWidthWithLeftAndRightPadding:80 topPadding:10 height:360];
//  [_pinView groupGrid:[_pinButtonArray subarrayWithRange:NSMakeRange(1, 9)] fillingWidthWithColumnCount:3 spacing:10];
//  [_button0 alignUnder:_button8 matchingCenterWithTopPadding:10 width:_button8.width height:_button8.height];
}

#pragma mark - ForgotPinDelegate

- (void)registerButtonPressed:(Button *)sender {
  [_delegate registerWithName:_nameField.text withPin:_pinDisplayCode];
}

@end
