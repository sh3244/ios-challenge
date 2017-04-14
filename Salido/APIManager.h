//
//  APIManager.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "SessionManager.h"
#import "CatalogRequestModel.h"
#import "CatalogResponseModel.h"
#import "Item.h"
#import "User.h"

@interface APIManager : SessionManager

+ (instancetype)sharedManager;

- (void)fetchCatalogItemsWith:(NSString *)search completion:(void (^)(NSArray<Item *> *items))completion;

- (void)fetchRealmUsersWithCompletion:(void (^)(NSArray<User *> *users))completion;
- (void)fetchRealmCartForUser:(User *)user completion: (void (^)(NSArray<Item *> *items))completion;

- (void)updateRealmWith:(Item *)item forUser:(User *)user withCount:(NSInteger)count;
- (void)checkoutRealmCartForUser:(User *)user;

@end
