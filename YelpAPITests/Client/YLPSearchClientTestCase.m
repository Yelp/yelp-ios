//
//  YLPSearchClientTestCase.m
//  YelpAPI
//
//  Created by David Chen on 1/28/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <XCTest/XCTest.h>
#import "YLPBusiness.h"
#import "YLPClient+Search.h"
#import "YLPCoordinate.h"
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"
#import "YLPSearch.h"
#import "YLPSortType.h"
#import "YLPClientTestCaseBase.h"

@interface YLPSearchClientTestCase : YLPClientTestCaseBase
@end

@implementation YLPSearchClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"search_response.json";
}

- (void)testGetSearchSuccess {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Test that YLPSearch has it's properties set, and that no errors exist."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    [self.client searchWithLocation:@"Donut Land" completionHandler:^(YLPSearch *searchResults, NSError *error) {
        XCTAssertNil(error);
        YLPBusiness *actualFirstBiz = searchResults.businesses[0];
        NSDictionary *expectedFirstBiz = expectedResponse[@"businesses"][0];
        
        XCTAssertEqualObjects(actualFirstBiz.name, expectedFirstBiz[@"name"]);
        XCTAssertEqual(actualFirstBiz.rating, [expectedFirstBiz[@"rating"] doubleValue]);
        
        XCTAssertEqual(searchResults.total, [expectedResponse[@"total"] intValue]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
