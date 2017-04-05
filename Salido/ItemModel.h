//
//  ItemModel.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ItemImageModel.h"

@interface ItemModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray<ItemImageModel *> *attributes;
@property (nonatomic, copy) NSNumber *minPrice;
@property (nonatomic, copy) NSString *vintage;
@property (nonatomic, copy) NSURL *url;

@end
