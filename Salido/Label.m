//
//  Label.m
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "Label.h"

@implementation Label

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize:42];
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

@end
