//
//  YLPBusinessClientTestCase.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <XCTest/XCTest.h>
#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPClient+Business.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"
#import "YLPReview.h"
#import "YLPUser.h"
#import "YLPClientTestCaseBase.h"

@interface YLPBusinessClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (BusinessClientTest)

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId;

@end

@implementation YLPBusinessClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"business_response.json";
}

- (void)testBusinessRequestWithId {
    NSURLRequest *request = [self.client businessRequestWithId:@"bogusBusinessId"];
    // Assert that the business id is inserted into the path properly
    XCTAssertEqualObjects(request.URL.path, @"/v3/businesses/bogusBusinessId");
}

- (void)testCategoriesOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPCategory on YLPBusiness success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSString *expectedAlias = expectedResponse[@"categories"][0][@"alias"];
    NSString *expectedName = expectedResponse[@"categories"][0][@"title"];
    
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(((YLPCategory *)business.categories[0]).alias, expectedAlias);
        XCTAssertEqualObjects(((YLPCategory *)business.categories[0]).name, expectedName);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testLocationOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPLocation on YLPBusiness success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedLocation = expectedResponse[@"location"];
    NSDictionary *expectedCoordinate = expectedResponse[@"coordinates"];
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(business.location.address[0], expectedLocation[@"address1"]);
        XCTAssertEqualObjects(business.location.postalCode, expectedLocation[@"zip_code"]);
        XCTAssertEqual(business.location.coordinate.latitude, [expectedCoordinate[@"latitude"] doubleValue]);
        XCTAssertEqual(business.location.coordinate.longitude, [expectedCoordinate[@"longitude"] doubleValue]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testLocationParsingNullAddressLine {
    NSDictionary *locationJSON = @{
        @"address1": @"549 Castro St",
        @"address2": [NSNull null],
        @"address3": @"",
        @"city": @"San Francisco",
        @"country": @"US",
        @"state": @"CA",
        @"zip_code": @"94114",
    };
    YLPLocation *location = [[YLPLocation alloc] initWithDictionary:locationJSON coordinate:nil];

    // Test that null and empty lines are properly stripped from the address
    XCTAssertEqual(location.address.count, 1);
    XCTAssertEqualObjects(location.address, @[@"549 Castro St"]);
}

@end
