//
//  PhoneNumberFieldDemoTests.m
//  PhoneNumberFieldDemoTests
//
//  Created by Colin Regan on 5/8/14.
//  Copyright (c) 2014 Lua Technologies, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LTPhoneNumberField.h"

@interface PhoneNumberFieldDemoTests : XCTestCase

@property (strong, nonatomic) LTPhoneNumberField *textField;

@end

@implementation PhoneNumberFieldDemoTests

- (void)setUp
{
    [super setUp];
    self.textField = [[LTPhoneNumberField alloc] initWithFrame:CGRectZero regionCode:nil];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSuccessfullyCreatesTextField
{
    XCTAssertNotNil(self.textField, @"Should be initialized before every test");
}

- (void)testTextFieldIsEmptyOnFirstLoad
{
    XCTAssertNil([self.textField phoneNumberWithFormat:LTPhoneNumberFormatE164], @"Should return nil if no phone number has been entered");
}

@end
