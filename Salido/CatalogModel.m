//
//  CatalogModel.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "CatalogModel.h"
#import "ItemModel.h"

@implementation CatalogModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"list" : @"List",
           @"offset" : @"Offset",
           @"total" : @"Total"
           };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)articlesJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:ItemModel.class];
}

@end
