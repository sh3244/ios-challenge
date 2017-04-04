//
//  SessionManager.h
//  Salido
//
//  Created by Sam on 4/2/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
