//
//  ItemImage.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemImage.h"

@implementation ItemImage

- (id)initWithMantleModel:(ItemImageModel *)itemImageModel {
  self = [super init];
  if (self) {

    _imageURL = itemImageModel.imageURL;
    _name = itemImageModel.name;

  }
  return self;
}

@end

