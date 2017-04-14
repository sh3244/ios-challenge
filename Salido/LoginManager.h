//
//  LoginManager.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>
#import "User.h"

@interface LoginManager : NSObject

+ (nonnull instancetype)sharedManager;

- (BOOL)currentlyLoggedIn;
- (nullable NSString *)currentUserName;

- (void)performLoginWithPin:(nonnull NSString *)pin completion:(void (^ _Nullable)(void))completion;
- (void)registerUser:(User * _Nonnull)user;
- (BOOL)canRegisterUser:(User * _Nonnull)user;
- (void)performLogOut;
- (User * _Nonnull)currentUser;

@end
