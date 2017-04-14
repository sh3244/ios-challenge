//
//  APIManager.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "APIManager.h"
#import <Realm/Realm.h>

static NSString *kItemListPath = @"api/beta2/service.svc/JSON/catalog?apikey=019a15f08aa396b28d6e0eab09ecade1";

@implementation APIManager

+ (instancetype)sharedManager {
  static dispatch_once_t onceToken;
  static APIManager *_sessionManager;
  dispatch_once(&onceToken, ^{
    _sessionManager = [[self alloc] init];
  });

  return _sessionManager;
}

- (NSURLSessionDataTask *)getItemsWithRequestModel:(CatalogRequestModel *)requestModel
                                              success:(void (^)(CatalogResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure{

  NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];

  return [self GET:kItemListPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *responseDictionary = (NSDictionary *)responseObject;

    NSError *error;
    CatalogResponseModel *list = [MTLJSONAdapter modelOfClass:CatalogResponseModel.class
                                           fromJSONDictionary:responseDictionary error:&error];
    success(list);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

// Not used
- (void)updateCatalogWithSearch:(NSString *)search completion:(void (^)(void))completion {
  CatalogRequestModel *requestModel = [CatalogRequestModel new];
  requestModel.offset = 0;
  requestModel.size = @(50).integerValue;
  requestModel.search = search;

  [self getItemsWithRequestModel:requestModel success:^(CatalogResponseModel *responseModel){
    [self updateRealmWith:responseModel completion:completion];
  } failure:^(NSError *error) {

  }];
}

// Not used
- (void)updateRealmWith:(CatalogResponseModel *)responseModel completion:(void (^)(void))completion {
  dispatch_async(dispatch_get_global_queue(0, 0), ^{
    @autoreleasepool {
      RLMRealm *realm = [RLMRealm defaultRealm];
      [realm beginWriteTransaction];
      [realm deleteAllObjects];
      [realm commitWriteTransaction];

      [realm beginWriteTransaction];
      for(ItemModel *item in responseModel.items){
        Item *itemRealm = [[Item alloc] initWithMantleModel:item];
        [realm addObject:itemRealm];
      }
      [realm commitWriteTransaction];
    }
  });
}

- (void)fetchCatalogItemsWith:(NSString *)search completion:(void (^)(NSArray<Item *> *items))completion {
  CatalogRequestModel *requestModel = [CatalogRequestModel new];
  requestModel.offset = 0;
  requestModel.size = @(50).integerValue;
  requestModel.search = search;

  [[APIManager sharedManager] getItemsWithRequestModel:requestModel success:^(CatalogResponseModel *responseModel){
    NSMutableArray *items = [NSMutableArray new];
    for(ItemModel *item in responseModel.items){
      Item *itemRealm = [[Item alloc] initWithMantleModel:item];
      [items addObject:itemRealm];
    }
    completion(items.copy);
  } failure:^(NSError *error) {

  }];
}

- (void)fetchRealmUsersWithCompletion:(void (^)(NSArray<User *> *users))completion {
  [RLMRealm defaultRealm];

  RLMResults<User *> *users = [User allObjects];
  NSMutableArray *allUsers = [NSMutableArray new];
  for (User *user in users) {
    [allUsers addObject:user];
  }

  completion(allUsers.copy);
}

- (void)fetchRealmCartForUser:(User *)user completion:(void (^)(NSArray<Item *> *items))completion {
  NSMutableArray *cartArray = [NSMutableArray new];
  for (Item *item in user.cart) {
    [cartArray addObject:item];
  }
  completion(cartArray.copy);
}

- (void)updateRealmWith:(Item *)item forUser:(User *)user withCount:(NSInteger)count {
  RLMRealm *realm = [RLMRealm defaultRealm];
  RLMResults<Item *> *items = [Item objectsWhere:@"name = %@", item.name];

  assert(items.count <= 1);
  for (Item *oldItem in items) {
    [realm beginWriteTransaction];
    oldItem.count += count;
    [realm commitWriteTransaction];
    return;
  }

  item.count = count;
  [realm beginWriteTransaction];
  [user.cart addObject:item];
  [realm commitWriteTransaction];
}

- (void)checkoutRealmCartForUser:(User *)user {
  RLMRealm *realm = [RLMRealm defaultRealm];

  [realm beginWriteTransaction];
  [user.cart removeAllObjects];
  [realm commitWriteTransaction];
}

@end
