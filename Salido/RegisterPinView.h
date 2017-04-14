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

- (void)registerWithFirstName:(NSString *)firstName lastName:(NSString *)lastName withPin:(NSString *)pin withEmail:(NSString *)email;

@end

@interface RegisterPinView : View

@property (nonatomic, strong) TextField *firstNameField;
@property (nonatomic, strong) TextField *lastNameField;
@property (nonatomic, strong) TextField *emailField;
@property (nonatomic, weak) id<RegisterPinDelegate> delegate;

@end
