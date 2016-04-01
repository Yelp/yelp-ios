//
//  YLPPhoneSearchClientTestCase.m
//  YelpAPI
//
//  Created by David Chen on 1/19/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPClient+PhoneSearch.h>
#import <YelpAPI/YLPCoordinate.h>
#import <YelpAPI/YLPCoordinateDelta.h>
#import <YelpAPI/YLPPhoneSearch.h>
#import <YelpAPI/YLPRegion.h>
#import <XCTest/XCTest.h>
#import "YLPClientTestCaseBase.h"

@interface YLPPhoneSearchClientTestCase : YLPClientTestCaseBase
@property (nonatomic, copy) NSString *minimalResource;
@end

@interface YLPClient (PhoneSearchTest)

- (void)businessWithParams:(NSDictionary *)params completionHandler:(void (^)(YLPPhoneSearch *phoneSearch, NSError *error))completionHandler;
@end

@implementation YLPPhoneSearchClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"phone_search_response.json";
    self.minimalResource = @"phone_search_no_region_response.json";
    
}

- (id)mockPhoneSearchRequestWithAllArgs {
    id mockPhoneSearchRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockPhoneSearchRequestWithAllArgs businessWithParams:[OCMArg any] completionHandler:[OCMArg any]]);
    return mockPhoneSearchRequestWithAllArgs;
}

- (void)testPhoneSearchRequestPassesParameters {
    id mockPhoneSearchRequestWithAllArgs = [self mockPhoneSearchRequestWithAllArgs];
    NSDictionary *params = @{@"cc": @"US", @"category": @"donut", @"phone": @"bogusPhoneNumber"};
    [self.client businessWithPhoneNumber:@"bogusPhoneNumber" countryCode:@"US" category:@"donut" completionHandler:^(YLPPhoneSearch *phoneSearch, NSError *error) {}];
    OCMExpect([mockPhoneSearchRequestWithAllArgs businessWithParams:params completionHandler:[OCMArg any]]);
}

- (void)testAttributesSetOnPhoneSearch{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test that YLPPhoneSearch has it's properties set, with full set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    [self.client businessWithPhoneNumber:@"4151231234" completionHandler:^(YLPPhoneSearch *phoneSearchResults, NSError *error) {
        NSArray *actualBusinesses = phoneSearchResults.businesses;
        XCTAssertEqual([actualBusinesses count], 2);
        XCTAssertEqual(phoneSearchResults.total, [expectedResponse[@"total"] integerValue]);
        XCTAssertNotNil(actualBusinesses[0]);
        XCTAssertNotNil(actualBusinesses[1]);
        XCTAssertNotNil(phoneSearchResults.region);
        XCTAssertEqualObjects([actualBusinesses[1] class], [YLPBusiness class]);
        XCTAssertEqualObjects([phoneSearchResults.region class], [YLPRegion class]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

- (void)testRegionSetOnPhoneSearch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test that YLPRegion is correctly set on YLPPhoneSearch."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedRegion = [self loadExpectedResponse:self.defaultResource][@"region"];
    [self.client businessWithPhoneNumber:@"4151231234" completionHandler:^(YLPPhoneSearch *phoneSearchResults, NSError *error) {
        YLPRegion *actualRegion = phoneSearchResults.region;
        XCTAssertEqual(actualRegion.center.latitude, [expectedRegion[@"center"][@"latitude"] doubleValue]);
        XCTAssertEqual(actualRegion.span.longitudeDelta, [expectedRegion[@"span"][@"longitude_delta"] doubleValue]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

- (void)testRegionNilWhenRegionNotInResponse {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test that YLPRegion is set to nil on YLPPhoneSearch, when the response doesn't contain the region key."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.minimalResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    [self.client businessWithPhoneNumber:@"4151231234" completionHandler:^(YLPPhoneSearch *phoneSearchResults, NSError *error) {
        YLPRegion *actualRegion = phoneSearchResults.region;
        XCTAssertNil(actualRegion);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

@end
