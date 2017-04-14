//
//  LoginPinView.h
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"

@protocol LoginPinDelegate <NSObject>

- (void)didEnterPin:(NSString *)pin;
- (void)didSelectRegister;
- (void)didSelectForgotPin;

@end

@interface LoginPinView : View

@property (nonatomic, weak) id<LoginPinDelegate> delegate;

- (void)warnValidation;
- (void)resetPinCode;

@end
