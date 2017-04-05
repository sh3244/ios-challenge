//
//  ItemDetailViewController.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "View.h"

@interface ItemDetailViewController ()

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ItemDetailViewController

- (instancetype)initWithItem:(Item *)item {
  self = [super init];

  _item = item;
  _webView = [UIWebView new];

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Item Detail";
  [self setupModalStyle];

  [self.view addSubview:_webView];

  [_webView fillSuperview];

  NSURL *targetURL = [NSURL URLWithString:_item.url];
  NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
  [_webView loadRequest:request];
}

@end
