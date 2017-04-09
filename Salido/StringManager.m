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

- (BOOL)validateSearchString:(NSString *)string withPattern:(NSString *)pattern {
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];

  NSAssert(regex, @"Unable to create regular expression");

  NSRange textRange = NSMakeRange(0, string.length);
  NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];

  BOOL didValidate = NO;

  if (matchRange.location != NSNotFound) didValidate = YES;

  return didValidate;
}

#pragma mark - Login Validation

- (BOOL)validateLoginString:(NSString *)string withPattern:(NSString *)pattern {
  NSError *error = nil;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];

  NSAssert(regex, @"Unable to create regular expression");

  NSRange textRange = NSMakeRange(0, string.length);
  NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];

  BOOL didValidate = NO;

  if (matchRange.location != NSNotFound) didValidate = YES;

  return didValidate;
}

@end
