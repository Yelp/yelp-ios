//
//  YelpAPITests.m
//  YelpAPITests
//
//  Created by David Chen on 12/14/15.
//
//
#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <XCTest/XCTest.h>
#import "YLPClient.h"
#import "YLPClientPrivate.h"
#import "YLPClientTestCaseBase.h"

@interface YLPClientTestCase : YLPClientTestCaseBase
@end

@implementation YLPClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"error.json";
    id _mockNSBundle = [OCMockObject niceMockForClass:[NSBundle class]];
    NSBundle *testMainBundle = [NSBundle bundleForClass:self.class];
    [[[[_mockNSBundle stub] classMethod] andReturn:testMainBundle] mainBundle];
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
    // Error case when API did not process the request, and thus errors are returned as NSError.
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

- (void)testQueryWithRequestHandlesErrorInAsResponseJSON {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Client query unit test, graceful error case."];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:400 headers:@{@"Content-Type":@"application/json"}];
    }];
    NSDictionary *expectedError = [self loadExpectedResponse:self.defaultResource];
    NSURLRequest *req = [self.client requestWithPath:self.bogusTestPath];
    
    [self.client queryWithRequest:req completionHandler:^(NSDictionary *responseJSON, NSError *error) {
        XCTAssertEqualObjects(kYLPErrorDomain, error.domain);
        XCTAssertEqualObjects(expectedError, error.userInfo);
        XCTAssertEqual((int)error.code, 400);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testRequestHeaders {
    NSURLRequest *request = [self.client requestWithPath:self.bogusTestPath];

    XCTAssertEqualObjects(request.HTTPMethod, @"GET");
    XCTAssertEqualObjects([request valueForHTTPHeaderField:@"Authorization"], @"Bearer accessToken");
    XCTAssertEqualObjects(request.URL.absoluteString, @"https://api.yelp.com/bogusPath");
    XCTAssertEqual(request.HTTPBody.length, 0);
}

- (void)testURLEncode {
    NSCharacterSet *allowedCharacters = [YLPClient URLEncodeAllowedCharacters];

    XCTAssertEqualObjects([@"abAB01_.-~" stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters], @"abAB01_.-~");
    XCTAssertEqualObjects([@"ab=AB&01" stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters], @"ab%3DAB%2601");
}

- (NSDictionary<NSString *, NSString *> *)paramsFromQueryString:(NSString *)string {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.query = string;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in components.queryItems) {
        params[item.name] = item.value;
    }

    return params;
}

- (void)testAuthRequest {
    NSURLRequest *authRequest = [YLPClient authRequestWithAppId:@"appId" secret:@"appSecret"];
    XCTAssertEqualObjects(authRequest.HTTPMethod, @"POST");
    XCTAssertEqualObjects(authRequest.URL.absoluteString, @"https://api.yelp.com/oauth2/token");

    NSString *body = [[NSString alloc] initWithData:authRequest.HTTPBody encoding:NSUTF8StringEncoding];
    NSDictionary *bodyParams = [self paramsFromQueryString:body];
    NSDictionary *expectedBodyParams = @{
        @"grant_type": @"client_credentials",
        @"client_id": @"appId",
        @"client_secret": @"appSecret",
    };
    XCTAssertEqualObjects(bodyParams, expectedBodyParams);

    XCTAssertNotNil([authRequest valueForHTTPHeaderField:@"Content-Length"]);
    XCTAssertEqualObjects([authRequest valueForHTTPHeaderField:@"Content-Type"], @"application/x-www-form-urlencoded");
}

@end
