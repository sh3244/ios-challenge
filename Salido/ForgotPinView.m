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
@property (nonatomic, strong) Button *forgotButton;

@property (nonatomic, strong) NSString *pinDisplayCode;

@end

@implementation ForgotPinView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  _pinDisplayCode = @"";
  _pinLabel = [Label new];
  [_pinLabel setText:_pinDisplayCode];
  _pinLabel.textAlignment = NSTextAlignmentCenter;
  _pinLabel.font = [UIFont boldSystemFontOfSize:48];
  [self addSubview:_pinLabel];

  _nameField = [TextField new];
  _nameField.placeholder = @"email";
  [self addSubview:_nameField];

  _forgotButton = [Button new];
  [_forgotButton setTitle:@"Find user by email" forState:UIControlStateNormal];
  [_forgotButton addTarget:self action:@selector(forgotButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  _forgotButton.titleLabel.font = [UIFont boldSystemFontOfSize:36];
  [self addSubview:_forgotButton];

  return self;
}

- (void)layoutSubviews {
  [_pinLabel anchorTopCenterFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
  [_nameField alignUnder:_pinLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
  [_forgotButton alignUnder:_nameField centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:80];
}

#pragma mark - ForgotPinDelegate

- (void)forgotButtonPressed:(Button *)sender {
  [_delegate findPinWithEmail:_nameField.text];
  [_nameField setText:@""];
  [_nameField resignFirstResponder];
}

@end
