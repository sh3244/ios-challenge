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

@end

//User *mantleUser = ...;
//RLMUser *realmUser = ...;
//
//// Loop through each persisted property in the Realm object and
//// copy the data from the equivalent Mantle property to it
//for (RLMProperty *property in realmUser.objectSchema.properties) {
//  id mantleValue = [mantleUser valueForKey:property.name];
//  [realmUser setValue:mantleValue forKey:property.name];
//}
