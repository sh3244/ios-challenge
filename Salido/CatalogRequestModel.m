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

#pragma mark - JSON Transformers

+ (NSValueTransformer *)articlesToDateJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                               NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

+ (NSValueTransformer *)articlesFromDateJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                               NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

@end
