//
//  ItemTableViewCell.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "Item.h"

@interface ItemTableViewCell : UITableViewCell

- (void)setupWithItem:(Item *)item;

@end
