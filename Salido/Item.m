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
  _name = itemModel.name;
  _type = itemModel.type;
  _minPrice = itemModel.minPrice.doubleValue;
  _vintage = itemModel.vintage;
  _url = itemModel.url.absoluteString;

  _images = [[RLMArray<ItemImage> alloc] initWithObjectClassName:[ItemImage className]];
  for (ItemImageModel *attribute in itemModel.attributes) {
    ItemImage *image = [[ItemImage alloc] initWithMantleModel:attribute];
    [_images addObject:image];
  }

  return self;
}

@end
