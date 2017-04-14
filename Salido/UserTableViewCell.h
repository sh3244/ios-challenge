//
//  UserTableViewCell.h
//  Salido
//
//  Created by Sam on 4/5/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import "View.h"
#import "User.h"

@interface UserTableViewCell : UITableViewCell

@property (nonatomic, strong) Label *userFirstNameLabel;
@property (nonatomic, strong) Label *userLastNameLabel;
@property (nonatomic, strong) Label *userDateLabel;
@property (nonatomic, strong) Label *userEmailLabel;
@property (nonatomic, strong) Label *cartCountLabel;

@end
