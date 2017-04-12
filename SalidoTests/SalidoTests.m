//
//  SalidoTests.m
//  SalidoTests
//
//  Created by Sam on 4/1/17.
//  Copyright © 2017 Salido. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StringManager.h"

@interface SalidoTests : XCTestCase

@property (nonatomic, weak) StringManager *stringManager;

@end

@implementation SalidoTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
  _stringManager = [StringManager sharedManager];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
    // Put the code you want to measure the time of here.
  }];
}

- (void)testNameValidation {
  XCTAssertTrue([_stringManager validateName:@"Sam"]);
  XCTAssertFalse([_stringManager validateName:@"sam!"]);
  XCTAssertFalse([_stringManager validateName:@"sam "]);
}

- (void)testEmailValidation {
  XCTAssertTrue([_stringManager validateEmail:@"sam@fdsaio.cdsaji"]);
  XCTAssertFalse([_stringManager validateEmail:@"sam@fdsai."]);
  XCTAssertFalse([_stringManager validateEmail:@"fdsafdsa@@.com"]);
  XCTAssertFalse([_stringManager validateEmail:@"fdsafdsa@.com."]);
}

- (void)testSearchValidation {
  XCTAssertTrue([_stringManager validateSearch:@"wine yard"]);
  XCTAssertFalse([_stringManager validateSearch:@"wine yards ."]);
}

@end
