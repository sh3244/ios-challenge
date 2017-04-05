//
//  ForgotPinView.h
//  Salido
//
//  Created by Sam on 4/4/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"

@protocol ForgotPinDelegate <NSObject>

- (void)registerWithName:(NSString *)name withPin:(NSString *)pin;

@end

@interface ForgotPinView : View

@property (nonatomic, strong) TextField *nameField;
@property (nonatomic, weak) id<ForgotPinDelegate> delegate;

@end
