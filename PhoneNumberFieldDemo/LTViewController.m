//
//  LTViewController.m
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, LLC. All rights reserved.
//

#import "LTViewController.h"

@implementation LTViewController

- (void)viewDidLoad
{
    self.phoneNumber.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"0"]) {
//        return NO;
    }
    return YES;
}

@end
