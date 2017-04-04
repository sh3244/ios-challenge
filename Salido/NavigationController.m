//
//  NavigationController.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationBar.translucent = NO;
  self.navigationBar.barStyle = UIBarStyleBlack;
  self.navigationBar.tintColor = [UIColor whiteColor];
  self.navigationBar.titleTextAttributes = @{
                                             NSForegroundColorAttributeName: [UIColor whiteColor]
                                             };
}

@end
