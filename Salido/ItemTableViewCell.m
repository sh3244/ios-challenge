//
//  ItemTableViewCell.m
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemTableViewCell.h"

@interface ItemTableViewCell()

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
    _minPriceLabel = [Label new];
    _vintageLabel = [Label new];
    _urlLabel = [Label new];
    _countField = [TextField new];
    _actionButton = [Button new];

    [_actionButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [_actionButton addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_countField setFont:[UIFont systemFontOfSize:30]];
    _countField.text = @"1";
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Expanded
  if (self.contentView.height > 120) {
    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_itemNameLabel];
    [self.contentView addSubview:_minPriceLabel];
    [self.contentView addSubview:_itemTypeLabel];
    [self.contentView addSubview:_vintageLabel];
    [self.contentView addSubview:_urlLabel];
    [self.contentView addSubview:_actionButton];
    [self.contentView addSubview:_countField];

    [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:100 height:100];
    [_itemNameLabel alignToTheRightOf:_itemImageView matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:20];
    [_minPriceLabel alignUnder:_itemNameLabel matchingLeftWithTopPadding:10 width:200 height:35];
    [_countField alignToTheRightOf:_minPriceLabel matchingTopWithLeftPadding:10 width:35 height:35];
    [_actionButton alignToTheRightOf:_countField matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:20];
    [_itemTypeLabel alignUnder:_itemImageView centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:20];
    [_vintageLabel alignUnder:_itemTypeLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:20];
    [_urlLabel alignUnder:_vintageLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:20];
  }
  // Compact
  else {
    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_itemNameLabel];
    [self.contentView addSubview:_minPriceLabel];
    [self.contentView addSubview:_actionButton];
    [self.contentView addSubview:_countField];

    [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:70 height:70];
    [_itemNameLabel alignToTheRightOf:_itemImageView matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:20];
    [_minPriceLabel alignUnder:_itemNameLabel matchingLeftWithTopPadding:10 width:230 height:35];
    [_countField alignToTheRightOf:_minPriceLabel matchingTopWithLeftPadding:10 width:35 height:35];
    [_actionButton alignToTheRightOf:_countField matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:35];
  }
}

- (void)prepareForReuse {
  [_itemImageView setImage:nil];
  [_itemImageView removeFromSuperview];
  [_itemNameLabel setText:@""];
  [_itemNameLabel removeFromSuperview];
  [_minPriceLabel setText:@""];
  [_minPriceLabel removeFromSuperview];
  [_itemTypeLabel setText:@""];
  [_actionButton removeFromSuperview];
  [_vintageLabel removeFromSuperview];
  [_countField removeFromSuperview];
  [_urlLabel removeFromSuperview];
}

- (void)actionButtonPressed {
  if (_delegate) {
    [_delegate itemCellActionButtonPressedWithValue:_countField.text.integerValue ?: 0 atIndex:_index];
  }
}

@end
