//
//  CatalogResponseModel.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "CatalogResponseModel.h"
#import "CatalogModel.h"
#import "ItemModel.h"

@implementation CatalogResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"items" : @"Products.List",
           @"total" : @"Total"
           };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)itemsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:ItemModel.class];
}

@end
