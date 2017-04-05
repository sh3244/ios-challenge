//
//  ItemTableViewCell.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemTableViewCell.h"

#import "Item.h"

@interface ItemTableViewCell()

@property (nonatomic, strong) ImageView *itemImageView;
@property (nonatomic, strong) Label *itemNameLabel;
@property (nonatomic, strong) Label *itemTypeLabel;

@property (nonatomic, strong) Item *item;

@end

@implementation ItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.contentView.clipsToBounds = YES;
    _item = [Item new];

    _itemImageView = [ImageView new];
    _itemNameLabel = [Label new];
    _itemTypeLabel = [Label new];

    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_itemNameLabel];
    [self.contentView addSubview:_itemTypeLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [UIView animateWithDuration:1 animations:^{
    if (self.contentView.height > 120) {
      [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:100 height:100];
      [_itemNameLabel alignToTheRightOf:_itemImageView matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:35];
      [_itemTypeLabel alignUnder:_itemNameLabel matchingLeftAndFillingWidthWithRightPadding:10 topPadding:10 height:35];
    }
    else {
      [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:0 height:0];
      [_itemNameLabel anchorTopLeftWithLeftPadding:10 topPadding:10 width:self.contentView.width height:35];
      [_itemTypeLabel anchorBottomLeftWithLeftPadding:10 bottomPadding:10 width:self.contentView.width height:35];
    }
  }];

  [super layoutSubviews];
}

- (void)setupWithName:(NSString *)name withType:(NSString *)type withItem:(Item *)item {
  [_itemNameLabel setText:name];
  [_itemTypeLabel setText:item.type];
}

- (void)prepareForReuse {
  [_itemImageView setImage:nil];
  [_itemTypeLabel setText:nil];
  [_itemNameLabel setText:nil];
}

@end
