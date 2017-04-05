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

- (void)performLoginWithPin:(nonnull NSString *)pin completion:(void (^ _Nullable)(void))completion;
- (void)registerUserWithName:(nonnull NSString *)name withPin:(nonnull NSString *)pin withEmail:(nonnull NSString *)email;
- (void)performLogOut;

@end
