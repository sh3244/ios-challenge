//
//  RegisterPinView.h
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facade/UIView+Facade.h>

#import "Button.h"
#import "Label.h"
#import "TextField.h"

@protocol RegisterPinDelegate <NSObject>

- (void)registerWithName:(NSString *)name withPin:(NSString *)pin;

@end

@interface RegisterPinView : UIView

@property (nonatomic, strong) TextField *nameField;
@property (nonatomic, weak) id<RegisterPinDelegate> delegate;

@end
