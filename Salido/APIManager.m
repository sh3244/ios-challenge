//
//  APIManager.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "APIManager.h"

static NSString *kItemListPath = @"api/beta2/service.svc/JSON/catalog?apikey=019a15f08aa396b28d6e0eab09ecade1";

@implementation APIManager

- (NSURLSessionDataTask *)getItemsWithRequestModel:(CatalogRequestModel *)requestModel
                                              success:(void (^)(CatalogResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure{

//  NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
//  NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:@{}];
//  [parametersWithKey setObject:kApiKey forKey:@"apikey"];

  return [self GET:kItemListPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *responseDictionary = (NSDictionary *)responseObject;

    NSError *error;
    CatalogResponseModel *list = [MTLJSONAdapter modelOfClass:CatalogResponseModel.class
                                           fromJSONDictionary:responseDictionary error:&error];
    success(list);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
  }];
}

@end
