//
//  LoginPinView.h
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facade/UIView+Facade.h>

#import "Button.h"
#import "Label.h"

@protocol LoginPinDelegate <NSObject>

- (void)userLoggedIn;
- (void)didEnterPin:(NSString *)pin;
- (void)didSelectRegister;
- (void)didSelectForgotPin;

@end

@interface LoginPinView : UIView

@property (nonatomic, weak) id<LoginPinDelegate> delegate;

- (void)resetPinCode;

@end
