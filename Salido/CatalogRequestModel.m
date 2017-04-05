//
//  CatalogRequestModel.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "CatalogRequestModel.h"

@implementation CatalogRequestModel

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyyMMdd";
  return dateFormatter;
}

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
//           @"listOffset": @"offset",
//           @"listSize": @"size",
//           @"searchTerm": @"search"
           };
}

@end
