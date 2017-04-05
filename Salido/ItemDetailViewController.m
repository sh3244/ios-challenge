//
//  ItemDetailViewController.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) ItemDetailView *itemDetailView;

@end

@implementation ItemDetailViewController

- (instancetype)initWithItem:(Item *)item {
  self = [super init];

  _item = item;

  _itemDetailView = [ItemDetailView new];

  self.view.backgroundColor = [UIColor lightGrayColor];

  self.title = @"Item Detail";

  [self setupModalStyle];

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view addSubview:_itemDetailView];

  [_itemDetailView fillSuperview];

  [_itemDetailView display:_item];
}

@end
