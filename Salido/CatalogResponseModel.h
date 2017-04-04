//
//  CatalogResponseModel.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ItemModel.h"

@interface CatalogResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray<ItemModel *> *items;
@property (nonatomic, copy) NSNumber *total;

@end
