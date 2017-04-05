//
//  RegisterPinView.h
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"

@protocol RegisterPinDelegate <NSObject>

- (void)registerWithName:(NSString *)name withPin:(NSString *)pin;

@end

@interface RegisterPinView : View

@property (nonatomic, strong) TextField *nameField;
@property (nonatomic, weak) id<RegisterPinDelegate> delegate;

@end
