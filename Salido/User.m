//
//  User.m
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName pin:(NSString *)pin {
  self = [self initWithFirstName:firstName lastName:lastName pin:pin email:@""];
  return self;
}

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName pin:(NSString *)pin email:(NSString *)email {
  self = [self initWithValue:@{
                        @"firstName" : firstName,
                        @"lastName" : lastName,
                        @"pin" : pin,
                        @"email" : email,
                        @"hiringDate" : [NSDate dateWithTimeIntervalSinceNow:0],
                        @"cart" : @[]
                        }];
  return self;
}

- (void)setHiringDateNow {
  _hiringDate = [NSDate dateWithTimeIntervalSinceNow:0];
}

@end
