//
//  LoginManager.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "LoginManager.h"

@interface LoginManager()

@property (nonatomic, assign) User *user;
@property (nonatomic, assign) BOOL loggedIn;

@end

@implementation LoginManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static LoginManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[LoginManager alloc] init];
  });

  return sharedManager;
}

- (instancetype)init {
  self = [super init];

  _loggedIn = NO;

  return self;
}

- (void)registerUserWithName:(NSString *)name withPin:(NSString *)pin {
  User *newUser = [User new];
  newUser.name = name;
  newUser.pin = pin;

  RLMRealm *realm = [RLMRealm defaultRealm];

  [realm beginWriteTransaction];
  [realm addObject:newUser];
  [realm commitWriteTransaction];
}

- (BOOL)canLoginWithPin:(NSString *)pin {
  [RLMRealm defaultRealm];

  RLMResults<User *> *users = [User objectsWhere:@"pin == %@", pin];

  if (users.count != 0) {
    return true;
  }

  return false;
}

- (void)performLoginWithPin:(NSString *)pin completion:(void (^)(void))completion {
  if ([self canLoginWithPin:pin]) {
    _loggedIn = YES;
    completion();
  }
  else {
    _loggedIn = NO;
  }
}

- (BOOL)isLoggedIn {
  return _loggedIn;
}

@end
