//
//  ItemTableViewCell.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "View.h"
#import "Item.h"

@protocol ItemTableViewCellDelegate <NSObject>

- (void (^)(void))itemCellActionButtonPressedWithValue:(NSInteger)value atIndex:(NSInteger)index;

@end

@interface ItemTableViewCell : UITableViewCell

@property (nonatomic, strong) Item *item;

@property (nonatomic, strong) ImageView *itemImageView;
@property (nonatomic, strong) Label *itemNameLabel;
@property (nonatomic, strong) Label *itemTypeLabel;
@property (nonatomic, strong) Label *minPriceLabel;
@property (nonatomic, strong) Label *vintageLabel;
@property (nonatomic, strong) Label *urlLabel;
@property (nonatomic, strong) TextField *countField;

@property (nonatomic, strong) Button *actionButton;

@property (nonatomic, weak) id<ItemTableViewCellDelegate> delegate;

@property (nonatomic, assign) NSInteger index;

@end
