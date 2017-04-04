//
//  Button.m
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "Button.h"

@implementation Button

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:42];
    [self setShowsTouchWhenHighlighted:YES];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

@end
