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
#import <XCTest/XCTest.h>
#import "YLPBusiness.h"
#import "YLPClient+PhoneSearch.h"
#import "YLPCoordinate.h"
#import "YLPSearch.h"
#import "YLPClientTestCaseBase.h"

@interface YLPPhoneSearchClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (PhoneSearchTest)

- (void)businessWithParams:(NSDictionary *)params completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler;
@end

@implementation YLPPhoneSearchClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"phone_search_response.json";
}

- (id)mockPhoneSearchRequestWithAllArgs {
    id mockPhoneSearchRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockPhoneSearchRequestWithAllArgs businessWithParams:[OCMArg any] completionHandler:[OCMArg any]]);
    return mockPhoneSearchRequestWithAllArgs;
}

- (void)testPhoneSearchRequestPassesParameters {
    id mockPhoneSearchRequestWithAllArgs = [self mockPhoneSearchRequestWithAllArgs];
    NSDictionary *params = @{@"cc": @"US", @"category": @"donut", @"phone": @"bogusPhoneNumber"};
    [self.client businessWithPhoneNumber:@"bogusPhoneNumber" countryCode:@"US" category:@"donut" completionHandler:^(YLPSearch *phoneSearch, NSError *error) {}];
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
    [self.client businessWithPhoneNumber:@"4151231234" completionHandler:^(YLPSearch *phoneSearchResults, NSError *error) {
        NSArray *actualBusinesses = phoneSearchResults.businesses;
        XCTAssertEqual([actualBusinesses count], 1);
        XCTAssertEqual(phoneSearchResults.total, [expectedResponse[@"total"] integerValue]);
        XCTAssertNotNil(actualBusinesses[0]);
        XCTAssertEqualObjects([actualBusinesses[0] class], [YLPBusiness class]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
