//
//  Item.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "Item.h"
#import "ItemModel.h"

@implementation Item

- (id)initWithMantleModel:(ItemModel *)itemModel {
  self = [super init];
  if (!self) {
    return nil;
  }
  self.name = itemModel.name;
  self.type = itemModel.type;

  return self;
}

@end
