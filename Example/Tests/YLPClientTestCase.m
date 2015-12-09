//
//  YLPClientTestCase.m
//  YelpAPI
//
//  Created by David Chen on 12/8/15.
//  Copyright (c) 2015 David Chen. All rights reserved.
//
#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <TDOAuth/TDOAuth.h>
#import <YelpAPI/YLPClient.h>

@interface YLPClientTestCase : XCTestCase
@property YLPClient *client;
@property dispatch_group_t requestGroup;
@property NSString *bogusTestPath;
@end

@implementation YLPClientTestCase

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    [self setClient:[[YLPClient alloc] initWithConsumerKey:@"consumerKey" consumerSecret:@"consumerSecret" token:@"token" tokenSecret:@"tokenSecret"]];
    [self setRequestGroup:dispatch_group_create()];
    dispatch_group_enter(self.requestGroup);
    [self setBogusTestPath:@"/bogusPath"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [OHHTTPStubs removeAllStubs];
}

- (id)mockRequestWithParams {
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
    NSDictionary *expectedDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"false", @"is_claimed",
                                  @"3.5", @"rating",
                                  nil];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:expectedDict options:0 error:nil];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:nil];
    }];
    
    
    [self.client queryWithRequest:[self.client requestWithPath:self.bogusTestPath] completionHandler:^(NSDictionary *responseJSON, NSError *error) {
        XCTAssertEqualObjects(expectedDict, responseJSON);
        dispatch_group_leave(self.requestGroup);
    }];
    dispatch_group_wait(self.requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
}

- (void)testQueryWithRequestHandlesError {
    NSError *expectedError = [NSError errorWithDomain:@"BogusTestingErrorDomain" code:-1 userInfo:@{@"error": @"error"}];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithError:expectedError];
    }];
    
    NSURLRequest *req = [self.client requestWithPath:self.bogusTestPath];
    [self.client queryWithRequest:req completionHandler:^(NSDictionary *responseJSON, NSError *error) {
        XCTAssertEqualObjects(expectedError, error);
        dispatch_group_leave(self.requestGroup);
    }];
    dispatch_group_wait(self.requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
}

@end
