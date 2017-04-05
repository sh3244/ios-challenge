//
//  ItemImageModel.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemImageModel.h"

@implementation ItemImageModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"name": @"Name",
           @"imageURL": @"Url"
           };
}

@end
