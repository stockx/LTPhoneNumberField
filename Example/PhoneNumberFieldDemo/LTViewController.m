//
//  LTViewController.m
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, Inc. All rights reserved.
//

#import "LTViewController.h"
#import "LTPhoneNumberField.h"

static NSString *const isValidNumber = @"containsValidNumber";

@implementation LTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.thumbsup.hidden = YES;
    
    self.phoneNumber.delegate = self;
    [self.phoneNumber addObserver:self forKeyPath:isValidNumber options:0 context:NULL];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"0"]) {
//        return NO;
    }
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:isValidNumber]) {
        LTPhoneNumberField *textField = object;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbsup.hidden = textField.containsValidNumber ? NO : YES;
        });
    }
}

- (void)dealloc
{
    [self.phoneNumber removeObserver:self forKeyPath:isValidNumber];
}

@end
