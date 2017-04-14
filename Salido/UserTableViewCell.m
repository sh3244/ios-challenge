//
//  UserTableViewCell.m
//  Salido
//
//  Created by Sam on 4/5/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "UserTableViewCell.h"

@interface UserTableViewCell()

@property (nonatomic, strong) User *user;

@end

@implementation UserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.contentView.clipsToBounds = YES;

    _userFirstNameLabel = [Label new];
    _userLastNameLabel = [Label new];
    _userDateLabel = [Label new];
    _userEmailLabel = [Label new];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Expanded
  if (self.contentView.height > 50) {
    [self.contentView addSubview:_userFirstNameLabel];
    [self.contentView addSubview:_userLastNameLabel];
    [self.contentView addSubview:_userDateLabel];
    [self.contentView addSubview:_userEmailLabel];
    [_userFirstNameLabel anchorTopLeftWithLeftPadding:10 topPadding:10 width:100 height:40];
    [_userLastNameLabel alignToTheRightOf:_userFirstNameLabel matchingTopWithLeftPadding:10 width:100 height:40];
    [_userDateLabel alignToTheRightOf:_userLastNameLabel fillingWidthWithLeftAndRightPadding:10 topPadding:10 height:40];
    [_userEmailLabel alignUnder:_userFirstNameLabel centeredFillingWidthWithLeftAndRightPadding:10 topPadding:10 height:40];
  }
  // Compact
  else {
    [self.contentView addSubview:_userFirstNameLabel];
    [self.contentView addSubview:_userLastNameLabel];
    [_userFirstNameLabel anchorTopLeftWithLeftPadding:10 topPadding:10 width:100 height:40];
    [_userLastNameLabel alignToTheRightOf:_userFirstNameLabel matchingTopAndFillingWidthWithLeftAndRightPadding:10 height:40];
  }
}

- (void)prepareForReuse {
  [_userFirstNameLabel removeFromSuperview];
  [_userLastNameLabel removeFromSuperview];
  [_userDateLabel removeFromSuperview];
  [_userEmailLabel removeFromSuperview];
}

@end
