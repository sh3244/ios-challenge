//
//  AlertManager.h
//  Salido
//
//  Created by Sam on 4/11/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+ (instancetype)sharedManager;

- (void)showAlertWithMessage:(NSString *)message;
- (void)showGoodAlertWithMessage:(NSString *)message;
- (void)showNeutralAlertWithMessage:(NSString *)message;

@end
