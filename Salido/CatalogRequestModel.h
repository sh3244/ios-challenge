//
//  CatalogRequestModel.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CatalogRequestModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSString *search;

@end
