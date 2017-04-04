//
//  ItemDetailView.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facade/UIView+Facade.h>

#import "Item.h"

@interface ItemDetailView : UIView

- (void)display:(Item *)item;

@end
