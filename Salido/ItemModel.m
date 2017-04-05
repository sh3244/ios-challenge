//
//  ItemModel.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"name": @"Name",
           @"type": @"Type",
           @"attributes": @"Labels",
           @"minPrice": @"PriceMin",
           @"vintage": @"Vintage",
           @"url": @"Url"
           };
}

+ (NSValueTransformer *)attributesJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:ItemImageModel.class];
}

@end
