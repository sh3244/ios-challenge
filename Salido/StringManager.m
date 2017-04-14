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
    sharedManager = [[self alloc] init];
  });

  return sharedManager;
}

- (NSString *)updatePin:(NSString *)pin withSingleValue:(NSString *)value {
  assert(value.length == 1);
  NSInteger pinOriginalLength = pin.length;

  NSString *pinEntered = [pin stringByReplacingOccurrencesOfString:@"*" withString:@""];

  // Reset if entire pin entered
  if (pinEntered.length == pinOriginalLength) {
    return [@"*" stringByPaddingToLength:pinOriginalLength withString:@"*" startingAtIndex:0];
  }

  NSString *newPinEntered = [pinEntered stringByAppendingString:value];

  while (newPinEntered.length < pinOriginalLength) {
    newPinEntered = [newPinEntered stringByAppendingString:@"*"];
  }

  return newPinEntered;
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

- (BOOL)validatePin:(NSString *)string {
  return [self validateString:string withRegexPattern:@"^[0-9]{6}$"];
}


- (BOOL)validateString:(NSString *)string withRegexPattern:(NSString *)pattern {
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];

  NSRange textRange = NSMakeRange(0, string.length);
  NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];

  BOOL didValidate = NO;

  if (matchRange.location != NSNotFound) didValidate = YES;

  return didValidate;
}

@end
