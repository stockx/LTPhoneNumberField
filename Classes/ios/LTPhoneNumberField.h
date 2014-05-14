//
//  LTPhoneNumberField.h
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTPhoneNumberField : UITextField

/**
 *  Returns a Boolean value indicating whether the entered phone number matches a valid pattern.
 */
@property (nonatomic, readonly) BOOL containsValidNumber;

/**
 *  Initializes and returns a newly allocated view object with the specified frame rectangle and region code.
 *
 *  @param frame    The frame rectangle for the view, measured in points.
 *  @param region   The ISO 3166-1 two-letter region code that denotes the region where the phone number is being entered. If nil, the current locale is used.
 *
 *  @return         An initialized LTPhoneNumberField object or nil if the object couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame regionCode:(NSString *)region;

@end
