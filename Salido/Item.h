//
//  Item.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Realm/Realm.h>
#import "ItemModel.h"
#import "ItemImage.h"

@interface Item : RLMObject

@property NSString *name;
@property NSString *type;
@property RLMArray<ItemImage> *images;
@property double minPrice;
@property NSString *vintage;
@property NSString *url;

- (id)initWithMantleModel:(ItemModel *)itemModel;

@end

RLM_ARRAY_TYPE(Item)
