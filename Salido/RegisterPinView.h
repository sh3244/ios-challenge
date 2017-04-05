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

- (BOOL)registerWithName:(NSString *)name withPin:(NSString *)pin withEmail:(NSString *)email;

@end

@interface RegisterPinView : View

@property (nonatomic, strong) TextField *nameField;
@property (nonatomic, strong) TextField *emailField;
@property (nonatomic, weak) id<RegisterPinDelegate> delegate;

@end
