//
//  AlertManager.m
//  Salido
//
//  Created by Sam on 4/11/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "AlertManager.h"
#import <CRToast/CRToast.h>

@interface AlertManager()

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation AlertManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static AlertManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[self alloc] init];
    sharedManager.isPresenting = NO;
  });

  return sharedManager;
}

- (void)showAlertWithMessage:(NSString *)message {
  if (_isPresenting) {
    return;
  }
  _isPresenting = YES;
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor redColor]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:^{
    _isPresenting = NO;
  }];
}

- (void)showGoodAlertWithMessage:(NSString *)message {
  if (_isPresenting) {
    return;
  }
  _isPresenting = YES;
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor colorWithRed:0.1 green:0.8 blue:0.2 alpha:1]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:^{
    _isPresenting = NO;
  }];
}

- (void)showNeutralAlertWithMessage:(NSString *)message {
  if (_isPresenting) {
    return;
  }
  _isPresenting = YES;
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor grayColor]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:^{
    _isPresenting = NO;
  }];
}

- (NSDictionary *)defaultOptionsWith:(NSDictionary *)moreOptions {
  NSMutableDictionary *combinedDictionary = [NSMutableDictionary new];
  combinedDictionary = moreOptions.mutableCopy;
  [combinedDictionary addEntriesFromDictionary:[self defaultOptions]];
  return combinedDictionary.copy;
}

- (NSMutableDictionary *)defaultOptions {
  return @{
           kCRToastNotificationTypeKey : @(CRToastTypeCustom),
           kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
           kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
           kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
           kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
           kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
           kCRToastNotificationPreferredHeightKey : @60.0
           }.mutableCopy;
}

@end
