//
//  ItemModel.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ItemModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *type;

@end
