//
//  SessionManager.m
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "SessionManager.h"

static NSString *kBaseURL = @"https://services.wine.com/";

@implementation SessionManager

- (instancetype)init {
  self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
  if (self) {
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
  }

  return self;
}

+ (instancetype)sharedManager {
  static SessionManager *_sessionManager = nil;

  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sessionManager = [[self alloc] init];
  });

  return _sessionManager;
}

@end
