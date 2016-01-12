//
//  YelpAPITests.m
//  YelpAPITests
//
//  Created by David Chen on 12/14/15.
//
//
#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <XCTest/XCTest.h>
#import <YelpAPI/YLPClient.h>
#import "YLPClientTestCaseBase.h"

@interface YLPClientTestCase : YLPClientTestCaseBase
@end

@implementation YLPClientTestCase

- (instancetype)mockRequestWithParams {
    id mockRequestWithParams = OCMPartialMock(self.client);
    OCMStub([mockRequestWithParams requestWithPath:[OCMArg any] params:[OCMArg any]]);
    return mockRequestWithParams;
}

- (void)testRequestWithHostNoParams {
    id mockRequestWithParams = [self mockRequestWithParams];
    [self.client requestWithPath:self.bogusTestPath];
    OCMVerify([mockRequestWithParams requestWithPath:self.bogusTestPath params:nil]);
}

- (void)testQueryWithRequestReturnsDictionary {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Client query unit test, success case."];
    NSDictionary *expectedDict = @{@"is_claimed":@"false", @"rating":@"3.5"};
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:expectedDict options:0 error:nil];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:nil];
    }];
    [self.client queryWithRequest:[self.client requestWithPath:self.bogusTestPath] completionHandler:^(NSDictionary *responseDict, NSError *error) {
        XCTAssertEqualObjects(expectedDict, responseDict);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testQueryWithRequestHandlesError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Client query unit test, error case."];
    NSError *expectedError = [NSError errorWithDomain:@"BogusTestingErrorDomain" code:-1 userInfo:@{@"error": @"error"}];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithError:expectedError];
    }];
    
    NSURLRequest *req = [self.client requestWithPath:self.bogusTestPath];
    [self.client queryWithRequest:req completionHandler:^(NSDictionary *responseJSON, NSError *error) {
        XCTAssertEqualObjects(expectedError, error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
