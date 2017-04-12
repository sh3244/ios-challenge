//
//  StringManager.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "StringManager.h"

@implementation StringManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static StringManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[StringManager alloc] init];
  });

  return sharedManager;
}

#pragma mark - Search Validation

- (BOOL)validateSearch:(NSString *)string {
  return [self validateString:string withRegexPattern:@"^[a-z0-9 ]+$"];
}

#pragma mark - Login Validation

- (BOOL)validateName:(NSString *)string {
  return [self validateString:string withRegexPattern:@"^[a-z0-9]+$"];
}

- (BOOL)validateEmail:(NSString *)string {
  return [self validateString:string withRegexPattern:@"^[a-z0-9]+@[a-z0-9]+\\.[a-z0-9]+$"];
}

- (BOOL)validateString:(NSString *)string withRegexPattern:(NSString *)pattern {
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];

  NSRange textRange = NSMakeRange(0, string.length);
  NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];

  BOOL didValidate = NO;

  if (matchRange.location != NSNotFound) didValidate = YES;

  return didValidate;
}

//- (BOOL)inputIsValid {
//  if ([[_pinDisplayCode stringByReplacingOccurrencesOfString:@"*" withString:@""] isEqualToString:_pinDisplayCode]) {
//    if (_nameField.text.length > 3 && [_nameField.text containsString:@" "]) {
//      return true;
//    }
//  }
//  return NO;
//}

@end
