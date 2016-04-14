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
#import "YLPCommonPrivate.h"
#import "YLPCoordinateDelta.h"
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"
#import "YLPRegion.h"
#import "YLPSearch.h"
#import "YLPSortType.h"
#import "YLPClientTestCaseBase.h"

@interface YLPSearchClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (SearchTest)
- (void)searchWithParams:(NSDictionary *)params completionHandler:(void (^)(YLPSearch *search, NSError *error))completionHandler;
@end

@implementation YLPSearchClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"search_response.json";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (id)mockSearchRequestWithAllArgs {
    id mockSearchRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockSearchRequestWithAllArgs searchWithParams:[OCMArg any] completionHandler:[OCMArg any]]);
    
    return mockSearchRequestWithAllArgs;
    
}

- (void)testGetSearchWithTermCreatesExpectedParams {
    id mockSearchRequestWithAllArgs = [self mockSearchRequestWithAllArgs];
    NSString *location = @"San Fransokyo";
    NSString *expectedTerm = @"some test term";
    double expectedLat = 30.1112322223;
    double expectedLong = -122.332322199980;
    YLPCoordinate *cll = [[YLPCoordinate alloc] initWithLatitude:expectedLat longitude:expectedLong];
    NSUInteger expectedLimit = 3;
    [self.client searchWithLocation:location currentLatLong:cll term:expectedTerm limit:expectedLimit offset:0 sort:YLPSortTypeBestMatched completionHandler:^(YLPSearch *search, NSError *error) {}];
    
    
    NSDictionary *expectedDict = @{@"term": expectedTerm, @"limit": [NSNumber numberWithInteger:expectedLimit], @"location": location, @"cll": cll.description};
    OCMExpect([mockSearchRequestWithAllArgs searchWithParams:expectedDict completionHandler:[OCMArg any]]);
}

- (void)testGetSearchWithLocationCreatesExpectedParams {
    id mockSearchRequestWithAllArgs = [self mockSearchRequestWithAllArgs];
    NSString *location = @"San Fransokyo";
    [self.client searchWithLocation:location completionHandler:^(YLPSearch *search, NSError *error) {}];
    
    OCMExpect([mockSearchRequestWithAllArgs searchWithParams:@{@"location": location} completionHandler:[OCMArg any]]);
    
}

- (void)testGetSearchWithBoundsCreatesExpectedParams {
    id mockSearchRequestWithAllArgs = [self mockSearchRequestWithAllArgs];
    
    YLPGeoBoundingBox *bounds = [[YLPGeoBoundingBox alloc] initWithSouthWestLongitude:1 southWestLatitude:1.2 northEastLatitude:1.3 northEastLongitude:1.5];
    [self.client searchWithBounds:bounds completionHandler:^(YLPSearch *search, NSError *error) {}];
    
    OCMExpect([mockSearchRequestWithAllArgs searchWithParams:@{@"bounds": bounds} completionHandler:[OCMArg any]]);
}

- (void)testGetSearchWithGeoCoordCreatesExpectedParams {
    id mockSearchRequestWithAllArgs = [self mockSearchRequestWithAllArgs];
    
    YLPGeoCoordinate *coordinate = [[YLPGeoCoordinate alloc] initWithLatitude:10 longitude:20 accuracy:15 altitude:12 altitudeAccuracy:1];
    
    [self.client searchWithGeoCoordinate:coordinate completionHandler:^(YLPSearch *search, NSError *error) {}];
    
    OCMExpect([mockSearchRequestWithAllArgs searchWithParams:@{@"ll": coordinate} completionHandler:[OCMArg any]]);
    
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
        
        YLPBusiness *actualSecondBiz = searchResults.businesses[1];
        NSDictionary *expectedSecondBiz = expectedResponse[@"businesses"][1];
        
        YLPRegion *actualRegion = searchResults.region;
        NSDictionary *expectedRegion = expectedResponse[@"region"];
        
        XCTAssertEqualObjects(actualFirstBiz.name, expectedFirstBiz[@"name"]);
        XCTAssertEqual(actualSecondBiz.rating, [expectedSecondBiz[@"rating"] doubleValue]);
        
        XCTAssertEqual(searchResults.total, [expectedResponse[@"total"] intValue]);
        [expectation fulfill];
        
        XCTAssertEqual(actualRegion.span.latitudeDelta, [expectedRegion[@"span"][@"latitude_delta"] doubleValue]);
        XCTAssertEqual(actualRegion.center.longitude, [expectedRegion[@"center"][@"longitude"] doubleValue]);
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
