//
//  ItemImageModel.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ItemImageModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *name;

@end
