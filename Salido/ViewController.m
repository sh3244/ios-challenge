//
//  ViewController.m
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  self.title = @"Title";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
  textField.returnKeyType = UIReturnKeyDone;
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

  return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{

  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

  [textField resignFirstResponder];
  return YES;
}

@end
