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

  _pinDisplayCode = @"******";
  _pinLabel = [Label new];
  [_pinLabel setText:_pinDisplayCode];
  [self addSubview:_pinLabel];

  _nameField = [TextField new];
  _nameField.placeholder = @"name";
  [self addSubview:_nameField];

  _forgotButton = [Button new];
  [_forgotButton setTitle:@"Find" forState:UIControlStateNormal];
  [_forgotButton addTarget:self action:@selector(forgotButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_forgotButton];

  return self;
}

- (void)layoutSubviews {

}

#pragma mark - ForgotPinDelegate

- (void)forgotButtonPressed:(Button *)sender {
  [_delegate registerWithName:_nameField.text withPin:_pinDisplayCode];
}

@end
