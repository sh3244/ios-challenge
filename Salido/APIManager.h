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

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)getItemsWithRequestModel:(CatalogRequestModel *)requestModel success:(void (^)(CatalogResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;

@end
