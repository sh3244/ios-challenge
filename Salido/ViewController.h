//
//  ViewController.h
//  Salido
//
//  Created by Sam on 4/3/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TransitionViewDelegate <NSObject>

- (void)launchViewController:(NSString *)viewControllerName;

@end

@interface ViewController : UIViewController <UITextFieldDelegate>

- (void)setupModalStyle;

- (void)dismissFromButton;

@end
