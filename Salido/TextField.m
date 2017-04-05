//
//  TextField.m
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "TextField.h"

@implementation TextField

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize:24];
    self.backgroundColor = [UIColor darkGrayColor];
    self.tintColor = [UIColor whiteColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

- (instancetype)initWithValidator:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize:24];
    self.backgroundColor = [UIColor darkGrayColor];
    self.tintColor = [UIColor whiteColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

@end
