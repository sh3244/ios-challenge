//
//  LoginManager.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "LoginManager.h"

@interface LoginManager()

@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, strong, nullable) User * user;

@end

@implementation LoginManager

- (instancetype)init {
  self = [super init];

  if (self) {
    _loggedIn = NO;
    User *user = [[User alloc] initWithFirstName:@"sam" lastName:@"sam" pin:@"111111" email:@"sam@sam.sam"];
    [self registerUser:user];
  }

  return self;
}

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static LoginManager *sharedManager;
  dispatch_once(&onceToken, ^{
    sharedManager = [[self alloc] init];
  });

  return sharedManager;
}

//first name duplicates are allowed, but pin, last name, and email addresses must be unique

- (void)loginWithPin:(NSString *)pin {
  [RLMRealm defaultRealm];

  RLMResults<User *> *users = [User objectsWhere:@"pin == %@", pin];
  _user = users.firstObject;
  _loggedIn = YES;
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

- (BOOL)canRegisterUser:(User *)user {
  RLMResults<User *> *users = [User allObjects];
  for (User *oldUser in users) {
    if ((oldUser.firstName == oldUser.lastName && oldUser.lastName == user.lastName) || oldUser.email == user.email || oldUser.pin == user.pin) {
      return NO;
    }
  }
  return YES;
}

- (void)registerUser:(User *)user {
  RLMRealm *realm = [RLMRealm defaultRealm];

  [realm beginWriteTransaction];
  [realm addObject:user];
  [realm commitWriteTransaction];
}

//a pin code (numeric values only, required)
//a first name (required)
//a last name (required)
//a valid email address (optional)

- (void)performLoginWithPin:(NSString *)pin completion:(void (^)(void))completion {
  if ([self tryLoginWithPin:pin]) {
    _loggedIn = YES;
    completion();
  }
  else {
    _loggedIn = NO;
  }
}

- (void)performLogOut {
  _loggedIn = NO;
  _user = nil;
}

- (BOOL)currentlyLoggedIn {
  return _loggedIn && _user != nil;
}

- (NSString *)currentUserName {
  if (!_loggedIn) {
    return @"";
  }
  return [_user.firstName stringByAppendingString:_user.lastName] ?: @"";
}

- (User *)currentUser {
  if (_user) {
    return _user;
  }
  return [User new];
}

@end
