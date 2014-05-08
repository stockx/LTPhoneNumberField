//
//  LTPhoneNumberField.m
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, LLC. All rights reserved.
//

#import "LTPhoneNumberField.h"
#import <NBAsYouTypeFormatter.h>

static NSString *const defaultRegion = @"US";

@interface LTPhoneNumberField () <UITextFieldDelegate>

@property (nonatomic, strong) NBAsYouTypeFormatter *formatter;
@property (nonatomic, weak) id<UITextFieldDelegate> externalDelegate;

- (void)setup;

@end

@implementation LTPhoneNumberField

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.formatter = [[NBAsYouTypeFormatter alloc] initWithRegionCode:defaultRegion];
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
    NSString *newText = nil;
    // When the range is invalid for the current message bar text ignore text change
    @try {
        newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception occurred on LTPhoneNumberField textFieldShouldChangeCharactersInRange:(%lu,%lu) replacementString:%@", (unsigned long)range.location, (unsigned long)range.length, string);
        NSAssert(NO, @"Caught range exception: %@", exception);
        return NO;
    }
    
    if ([self.externalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.externalDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return YES;
    }
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
