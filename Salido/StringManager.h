//
//  StringManager.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)updatePin:(NSString *)pin withSingleValue:(NSString *)value;

- (BOOL)validateName:(NSString *)string;
- (BOOL)validateEmail:(NSString *)string;
- (BOOL)validateSearch:(NSString *)string;
- (BOOL)validatePin:(NSString *)string;

@end
