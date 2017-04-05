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
@property (nonatomic, strong) Label *minPriceLabel;
@property (nonatomic, strong) Label *vintageLabel;
@property (nonatomic, strong) Label *urlLabel;

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
    _minPriceLabel = [Label new];
    _vintageLabel = [Label new];
    _urlLabel = [Label new];
  }
  return self;
}

- (void)layoutSubviews {
  if (self.contentView.height > 120) {
    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_itemNameLabel];
    [self.contentView addSubview:_minPriceLabel];
    [self.contentView addSubview:_itemTypeLabel];
    [self.contentView addSubview:_vintageLabel];
    [self.contentView addSubview:_urlLabel];
    [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:100 height:100];
    [_itemNameLabel alignToTheRightOf:_itemImageView matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:35];
    [_minPriceLabel alignUnder:_itemNameLabel matchingLeftAndFillingWidthWithRightPadding:10 topPadding:10 height:35];
    [_itemTypeLabel alignUnder:_itemImageView centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:35];
    [_vintageLabel alignUnder:_itemTypeLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:35];
    [_urlLabel alignUnder:_vintageLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:35];
  }
  else {
    [self.contentView addSubview:_itemImageView];
    [self.contentView addSubview:_itemNameLabel];
    [self.contentView addSubview:_minPriceLabel];
    [_itemImageView anchorTopLeftWithLeftPadding:10 topPadding:10 width:0 height:0];
    [_itemNameLabel anchorTopLeftWithLeftPadding:10 topPadding:10 width:self.contentView.width height:35];
    [_minPriceLabel anchorBottomLeftWithLeftPadding:10 bottomPadding:10 width:self.contentView.width height:35];
  }

  [super layoutSubviews];
}

- (void)setupWithItem:(Item *)item {
  [_itemNameLabel setText:item.name];
  [_minPriceLabel setText:@(item.minPrice).stringValue];
  [_itemTypeLabel setText:item.type];
  [_vintageLabel setText:item.vintage];

  NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:item.url];
  [str addAttribute: NSLinkAttributeName value: item.url range: NSMakeRange(0, str.length)];

  [_urlLabel setAttributedText:str];

  ItemImage *image = item.images.firstObject;
  NSString *imageURL = image.imageURL;
  dispatch_async(dispatch_get_global_queue(0,0), ^{
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
    if (data == nil)
      return;
    dispatch_async(dispatch_get_main_queue(), ^{
      [_itemImageView setImage:[UIImage imageWithData: data]];
    });
  });
}

- (void)prepareForReuse {
  [_itemImageView removeFromSuperview];
  [_itemNameLabel removeFromSuperview];
  [_itemTypeLabel removeFromSuperview];
  [_minPriceLabel removeFromSuperview];
  [_vintageLabel removeFromSuperview];
  [_urlLabel removeFromSuperview];
}

@end
