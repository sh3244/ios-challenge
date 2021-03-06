//
//  User.h
//  Salido
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <Realm/Realm.h>
#import "Item.h"

@interface User : RLMObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *pin;

@property NSString *email;

@property RLMArray<Item *><Item> *cart;

@property NSDate *hiringDate;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName pin:(NSString *)pin email:(NSString *)email;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName pin:(NSString *)pin;

- (void)setHiringDateNow;

//@property NSString *phone;

@end

/*
 Bool	@property BOOL value;	@property NSNumber<RLMBool> *value;

 Int	@property int value;	@property NSNumber<RLMInt> *value;

 Float	@property float value;	@property NSNumber<RLMFloat> *value;

 Double	@property double value;	@property NSNumber<RLMDouble> *value;

 String	@property NSString *value; 1	@property NSString *value;

 Data	@property NSData *value; 1	@property NSData *value;

 Date	@property NSDate *value; 1	@property NSDate *value;

 Object	n/a: must be optional	@property Object *value;

 List	@property RLMArray<Object *><Object> *value;	n/a: must be non-optional

 LinkingObjects	@property (readonly) RLMLinkingObjects<Object *> *value; 2	n/a: must be non-optional
*/
