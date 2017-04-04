//
//  ItemDetailView.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemDetailView.h"

@interface ItemDetailView()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemNameLabel;
@property (nonatomic, strong) UILabel *itemTypeLabel;

@end

@implementation ItemDetailView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  _itemImageView = [UIImageView new];
  _itemNameLabel = [UILabel new];
  _itemTypeLabel = [UILabel new];

  _itemImageView.backgroundColor = [UIColor redColor];

  [self addSubview:_itemImageView];
  [self addSubview:_itemNameLabel];
  [self addSubview:_itemTypeLabel];

  return self;
}

- (void)layoutSubviews {
  [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:300 height:300];
  [_itemNameLabel alignUnder:_itemImageView centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:20];
  [_itemTypeLabel alignUnder:_itemNameLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:20];
}

- (void)display:(Item *)item {
  [_itemNameLabel setText:item.name];
  [_itemTypeLabel setText:item.type];
}

@end
