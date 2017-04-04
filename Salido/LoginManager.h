//
//  LoginManager.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Item.h"
#import "User.h"

#import <Realm/Realm.h>

@interface LoginManager : NSObject

+ (nonnull instancetype)sharedManager;

- (void)performLoginWithPin:(nonnull NSString *)pin completion:(void (^ _Nullable)(void))completion;
- (void)registerUserWithName:(nonnull NSString *)name withPin:(nonnull NSString *)pin;
- (BOOL)isLoggedIn;

@end
