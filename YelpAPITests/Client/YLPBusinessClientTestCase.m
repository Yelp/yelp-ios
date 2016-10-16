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
#import "YLPReview.h"
#import "YLPUser.h"
#import "YLPClientTestCaseBase.h"

@interface YLPBusinessClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (BusinessClientTest)

- (void)businessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;

@end

@implementation YLPBusinessClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"business_response.json";
}

- (id)mockBusinessRequestWithAllArgs {
    id mockBusinessRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockBusinessRequestWithAllArgs businessWithId:[OCMArg any] params:[OCMArg any] completionHandler:[OCMArg any]]);
    return mockBusinessRequestWithAllArgs;
}

- (void)testNullParams {
    [self.client businessWithId:@"gary-danko" countryCode:@"" languageCode:@"" languageFilter:NO actionLinks:NO completionHandler:^(YLPBusiness *business, NSError *error) {}];
    [self.client businessWithId:@"gary-danko-san-francisco" countryCode:nil languageCode:nil languageFilter:NO actionLinks:NO completionHandler:^(YLPBusiness *business, NSError *error) {}];
}
- (void)testBusinessRequestWithId {
    id mockBusinessRequestWithIdWithAllArgs = [self mockBusinessRequestWithAllArgs];
    [self.client businessWithId:@"bogusBusinessId" completionHandler:^(YLPBusiness *business, NSError *error) {}];
    
    OCMVerify([mockBusinessRequestWithIdWithAllArgs businessWithId:@"bogusBusinessId" params:nil completionHandler:[OCMArg any]]);
}

- (void)testBusinessRequestResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Business query test, success case."];

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertNil(error);
        //String assignment testing
        XCTAssertEqualObjects(business.identifier, @"gary-danko-san-francisco");
        //URL assignment testing
        XCTAssertEqualObjects([business.URL absoluteString], [expectedResponse objectForKey:@"url"]);
        //Number assignment testing
        XCTAssertEqual(business.rating, [expectedResponse[@"rating"] doubleValue]);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
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

@end
