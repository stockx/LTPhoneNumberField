//
//  NBAsYouTypeFormatter.h
//  libPhoneNumber
//
//  Created by ishtar on 13. 2. 25..
//

#import <Foundation/Foundation.h>

@interface NBAsYouTypeFormatter : NSObject

- (id)initWithRegionCode:(NSString*)regionCode;
- (id)initWithRegionCodeForTest:(NSString*)regionCode;
- (id)initWithRegionCode:(NSString*)regionCode bundle:(NSBundle *)bundle;
- (id)initWithRegionCodeForTest:(NSString*)regionCode bundle:(NSBundle *)bundle;

- (NSString*)inputDigit:(NSString*)nextChar;
- (NSString*)inputDigitAndRememberPosition:(NSString*)nextChar;

- (NSString*)removeLastDigit;

/**
 Removes the digit at index `formattedPhoneNumberIndex`
 in the formatted phone number.
 
 If the character at `formattedPhoneNumberIndex` is not a digit 
 (e.g. '(', '+', '-'), will remove the nearest digit to the left.
 */
- (NSString*)removeDigitAt:(NSInteger)formattedPhoneNumberIndex;
- (NSString*)removeLastDigitAndRememberPosition;

- (NSInteger)getRememberedPosition;
- (void)clear;

@end
