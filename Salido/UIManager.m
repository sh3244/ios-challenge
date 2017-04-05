//
//  UIManager.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "UIManager.h"

@implementation UIManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static UIManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[UIManager alloc] init];
  });

  return sharedManager;
}

@end
