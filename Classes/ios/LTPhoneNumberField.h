//
//  LTPhoneNumberField.h
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPhoneNumberField : UITextField

@property (nonatomic, readonly, getter = isValidNumber) BOOL validNumber;

- (instancetype)initWithFrame:(CGRect)frame regionCode:(NSString *)region;

@end
