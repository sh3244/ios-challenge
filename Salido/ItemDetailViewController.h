//
//  ItemDetailViewController.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

#import "ItemDetailView.h"

#import "Item.h"

@interface ItemDetailViewController : ViewController

- (nonnull instancetype)initWithItem:(nonnull Item *)item;

@end
