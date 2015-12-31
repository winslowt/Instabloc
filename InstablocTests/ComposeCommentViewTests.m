//
//  ComposeCommentViewTests.m
//  Instabloc
//
//  Created by Tony  Winslow on 12/30/15.
//  Copyright © 2015 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ComposeCommentView.h"

@interface ComposeCommentViewTests : XCTestCase

@end

@implementation ComposeCommentViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testComposeCommentViewSetText {
    ComposeCommentView *testCommentView = [[ComposeCommentView alloc] init];
    [testCommentView setText:@"test Text"];
    
    XCTAssertEqual(testCommentView.isWritingComment, (BOOL)YES, @"ComposeCommentView correctly set the isWritingComment when there is text.");
}


- (void)testComposeCommentViewSetNoText {
    ComposeCommentView *testCommentView = [[ComposeCommentView alloc] init];
    
    XCTAssertEqual(testCommentView.isWritingComment, (BOOL)NO, @"ComposeCommentView correctly set the isWritingComment to No when there is no text.");
}

@end
