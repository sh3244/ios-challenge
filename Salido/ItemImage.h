//
//  ItemImage.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Realm/Realm.h>
#import "ItemImageModel.h"

@interface ItemImage : RLMObject

@property NSString *imageURL;
@property NSString *name;

- (id)initWithMantleModel:(ItemImageModel *)itemImageModel;

@end

RLM_ARRAY_TYPE(ItemImage)
