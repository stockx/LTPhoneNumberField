//
//  LTViewController.h
//  PhoneNumberFieldDemo
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@end
