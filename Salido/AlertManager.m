//
//  AlertManager.m
//  Salido
//
//  Created by Sam on 4/11/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "AlertManager.h"
#import <CRToast/CRToast.h>

@implementation AlertManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static AlertManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[AlertManager alloc] init];
  });

  return sharedManager;
}

- (void)showAlertWithMessage:(NSString *)message {
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor redColor]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:nil];
}

- (void)showGoodAlertWithMessage:(NSString *)message {
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor greenColor]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:nil];
}

- (void)showNeutralAlertWithMessage:(NSString *)message {
  NSDictionary *options = @{
                            kCRToastTextKey : message,
                            kCRToastBackgroundColorKey : [UIColor grayColor]
                            };
  [CRToastManager showNotificationWithOptions:[self defaultOptionsWith:options] completionBlock:nil];
}

- (NSDictionary *)defaultOptionsWith:(NSDictionary *)moreOptions {
  NSMutableDictionary *combinedDictionary = [NSMutableDictionary new];
  combinedDictionary = moreOptions.mutableCopy;
  [combinedDictionary addEntriesFromDictionary:[self defaultOptions]];
  return combinedDictionary.copy;
}

- (NSMutableDictionary *)defaultOptions {
  return @{
           kCRToastNotificationPreferredHeightKey : @40,
           kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
           kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
           kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
           kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
           kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
           }.mutableCopy;
}

@end
