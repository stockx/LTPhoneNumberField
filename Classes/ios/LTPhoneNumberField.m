//
//  LTPhoneNumberField.m
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, LLC. All rights reserved.
//

#import "LTPhoneNumberField.h"
#import <NBAsYouTypeFormatter.h>

@interface LTPhoneNumberField () <UITextFieldDelegate>

@property (nonatomic, strong) NBAsYouTypeFormatter *formatter;
@property (nonatomic, weak) id<UITextFieldDelegate> externalDelegate;

- (void)setupWithRegionCode:(NSString *)region;

@end

@implementation LTPhoneNumberField

#pragma mark - Initialization

/**
 *  Initializes and returns a newly allocated view object with the specified frame rectangle and region code.
 *
 *  @param frame    The frame rectangle for the view, measured in points.
 *  @param region   The ISO 3166-1 two-letter region code that denotes the region where the phone number is being entered. If nil, the current locale is used.
 *
 *  @return         An initialized LTPhoneNumberField object or nil if the object couldn't be created.
 */
- (instancetype)initWithFrame:(CGRect)frame regionCode:(NSString *)region
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithRegionCode:region];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame regionCode:nil];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupWithRegionCode:nil];
    }
    return self;
}

- (void)setupWithRegionCode:(NSString *)region
{
    region = region ?: [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    self.formatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:region];
    super.delegate = self;
}

#pragma mark - Delegate overrides

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    self.externalDelegate = delegate;
}

- (id<UITextFieldDelegate>)delegate
{
    return self.externalDelegate;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.externalDelegate textFieldShouldBeginEditing:textField];
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.externalDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.externalDelegate textFieldShouldEndEditing:textField];
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.externalDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL singleInsertAtEnd = (string.length == 1) && (range.location == textField.text.length);
    BOOL singleDeleteFromEnd = (string.length == 0) && (range.length == 1) && (range.location == textField.text.length - 1);

    BOOL shouldChange = NO;
    NSString *formattedNumber;
    NSString *prefix;
    NSRange formattedRange;
    NSString *removedCharacter;
    if (singleInsertAtEnd) {
        formattedNumber = [self.formatter inputDigit:string];
        if ([formattedNumber hasSuffix:string]) {
            formattedRange = [formattedNumber rangeOfString:string options:(NSBackwardsSearch | NSAnchoredSearch)];
            prefix = [formattedNumber stringByReplacingCharactersInRange:formattedRange withString:@""];
            shouldChange = YES;
        }
    } else if (singleDeleteFromEnd) {
        formattedNumber = [self.formatter removeLastDigit];
        removedCharacter = [textField.text substringWithRange:range];
        prefix = [formattedNumber stringByAppendingString:removedCharacter];
        formattedRange = [prefix rangeOfString:removedCharacter options:(NSBackwardsSearch | NSAnchoredSearch)];
        shouldChange = YES;
    }
    
    if (shouldChange) {
        if ([self.externalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            textField.text = prefix;
            if (![self.externalDelegate textField:textField shouldChangeCharactersInRange:formattedRange replacementString:string]) {
                // Revert changes
                if (singleInsertAtEnd) {
                    [self.formatter removeLastDigit];
                } else if (singleDeleteFromEnd) {
                    [self.formatter inputDigit:removedCharacter];
                }
            } else {
                textField.text = formattedNumber;
                [self checkValidity:formattedNumber];
            }
        } else {
            textField.text = formattedNumber;
            [self checkValidity:formattedNumber];
        }
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.externalDelegate textFieldShouldClear:textField];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.externalDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.externalDelegate textFieldShouldReturn:textField];
    } else {
        return YES;
    }
}

@end
