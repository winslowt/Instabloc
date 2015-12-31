//
//  ActualMediaTests.m
//  Instabloc
//
//  Created by Tony  Winslow on 12/30/15.
//  Copyright © 2015 Bloc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MediaPlay.h"

@interface ActualMediaTests : XCTestCase

@end

@implementation ActualMediaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testThatThisInitializationWorks {
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"mediaURL" : @"http://www.example.com/example.html"};
    MediaPlay *testMedia = [[MediaPlay alloc] initWithDictionary:sourceDictionary];
    testMedia.mediaURL = [NSURL URLWithString:sourceDictionary[@"mediaURL"]];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"mediaURL"]], @"The mediaURL should be equal");
}
@end
