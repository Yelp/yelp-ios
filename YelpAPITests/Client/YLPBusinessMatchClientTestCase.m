//
//  YLPBusinessMatchMatchClientTestCase.m
//  YelpAPITests
//
//  Created by Kevin Farst on 4/5/18.
//

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <XCTest/XCTest.h>
#import "YLPBusinessMatch.h"
#import "YLPClient+Business.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"
#import "YLPClientTestCaseBase.h"

@interface YLPBusinessMatchClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (BusinessClientTest)

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId;

@end

@implementation YLPBusinessMatchClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"business_match_response.json";
}

- (void)testBusinessMatchLookupRequestResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Business match lookup match query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    
    NSDictionary *info = @{
                           @"name": @"Cafe",
                           @"city": @"San Francisco",
                           @"state": @"California",
                           @"country": @"US"
                           };
    
    [self.client findBusinessMatchesWithInfo:info completionHandler:^(NSArray<YLPBusinessMatch *> * _Nullable businesses, NSError * _Nullable error) {
        XCTAssertNil(error);
        
        // Number of results testing
        XCTAssertGreaterThan([businesses count], 1);
        
        YLPBusinessMatch *firstMatch = businesses[0];
        YLPBusinessMatch *expectedFirstMatch = [[YLPBusinessMatch alloc] initWithDictionary:expectedResponse[@"businesses"][0]];

        // Location testing
        XCTAssertEqualObjects(firstMatch.location.city, expectedFirstMatch.location.city);
        // Name testing
        XCTAssertEqualObjects(firstMatch.name, expectedFirstMatch.name);
        // Display name testing
        XCTAssertEqualObjects(firstMatch.displayAddress, expectedFirstMatch.displayAddress);
        
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testBusinessBestMatchRequestResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Business best match query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSDictionary *businessMatchResponse = [self loadExpectedResponse:self.defaultResource];
        
        // Best business match will only return one match in the response array
        NSArray<YLPBusinessMatch *> *matchesArr = businessMatchResponse[@"businesses"];
        NSArray<YLPBusinessMatch *> *singleMatchArr = @[[matchesArr firstObject]];
        NSDictionary *expectedResponse = @{ @"businesses": singleMatchArr };
        
        NSError *error;
        NSData *dataResponse = [NSJSONSerialization dataWithJSONObject:expectedResponse options:NSJSONWritingPrettyPrinted error:&error];

        return [OHHTTPStubsResponse responseWithData:dataResponse statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    
    NSDictionary *info = @{
                           @"name": @"Cafe",
                           @"city": @"San Francisco",
                           @"state": @"California",
                           @"country": @"US"
                           };
    
    [self.client bestBusinessMatchWithInfo:info completionHandler:^(NSArray<YLPBusinessMatch *> * _Nullable businesses, NSError * _Nullable error) {
        XCTAssertNil(error);
        
        // Number of results testing
        XCTAssertEqual([businesses count], 1);
        
        YLPBusinessMatch *firstMatch = businesses[0];
        YLPBusinessMatch *expectedFirstMatch = [[YLPBusinessMatch alloc] initWithDictionary:expectedResponse[@"businesses"][0]];
        
        // Location testing
        XCTAssertEqualObjects(firstMatch.location.city, expectedFirstMatch.location.city);
        // Name testing
        XCTAssertEqualObjects(firstMatch.name, expectedFirstMatch.name);
        // Display name testing
        XCTAssertEqualObjects(firstMatch.displayAddress, expectedFirstMatch.displayAddress);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}
@end

