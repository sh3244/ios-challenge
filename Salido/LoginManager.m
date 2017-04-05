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

- (instancetype)init {
  self = [super init];

  if (self) {
    _loggedIn = NO;
  }

  return self;
}

+ (instancetype)sharedManager {
  static LoginManager *sharedManager = nil;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedManager = [[self alloc] init];
  });

  return sharedManager;
}

- (void)loginWithPin:(NSString *)pin {
  [RLMRealm defaultRealm];

  RLMResults<User *> *users = [User objectsWhere:@"pin == %@", pin];
  _user = users.firstObject;
}

- (BOOL)canLoginWithPin:(NSString *)pin {
  [RLMRealm defaultRealm];

  RLMResults<User *> *users = [User objectsWhere:@"pin == %@", pin];

  assert(users.count <= 1);

  if (users.count == 1) {
    return true;
  }

  return false;
}

- (BOOL)tryLoginWithPin:(NSString *)pin {
  if ([self canLoginWithPin:pin]) {
    [self loginWithPin:pin];
    return true;
  }
  return false;
}

#pragma mark - Public

- (void)registerUserWithName:(NSString *)name withPin:(NSString *)pin withEmail:(NSString *)email {
  User *newUser = [User new];
  newUser.name = name;
  newUser.pin = pin;
  newUser.email = email;

  RLMRealm *realm = [RLMRealm defaultRealm];

  [realm beginWriteTransaction];
  [realm addObject:newUser];
  [realm commitWriteTransaction];
}

- (void)performLoginWithPin:(NSString *)pin completion:(void (^)(void))completion {
  if ([self tryLoginWithPin:pin]) {
    _loggedIn = YES;
    completion();
  }
  else {
//    _loggedIn = NO;
  }
}

- (void)performLogOut {
  _loggedIn = NO;
  _user = nil;
}

- (BOOL)currentlyLoggedIn {
  return _loggedIn;
}

@end
