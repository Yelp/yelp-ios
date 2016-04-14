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
#import "YLPGiftCertificate.h"
#import "YLPGiftCertificateOption.h"
#import "YLPDeal.h"
#import "YLPDealOption.h"
#import "YLPLocation.h"
#import "YLPReview.h"
#import "YLPUser.h"
#import "YLPClientTestCaseBase.h"

@interface YLPBusinessClientTestCase : YLPClientTestCaseBase
@property (nonatomic, copy) NSString *minimalResource;
@end

@interface YLPClient (BusinessClientTest)

- (void)businessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;

@end

@implementation YLPBusinessClientTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"business_response.json";
    self.minimalResource = @"minimum_business_response.json";
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
        //Bool assignment testing
        XCTAssertEqual(business.isClosed, [expectedResponse[@"is_closed"] boolValue]);
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
    NSString *expectedAlias = expectedResponse[@"categories"][0][1];
    NSString *expectedName = expectedResponse[@"categories"][0][0];
    
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
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(business.location.displayAddress, expectedLocation[@"display_address"]);
        XCTAssertEqualObjects(business.location.crossStreets, nil);
        XCTAssertEqualObjects(business.location.postalCode, expectedLocation[@"postal_code"]);
        XCTAssertEqual(business.location.coordinate.latitude,[expectedLocation[@"coordinate"][@"latitude"] doubleValue]);
        XCTAssertEqual(business.location.coordinate.longitude, [expectedLocation[@"coordinate"][@"longitude"] doubleValue]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testLocationOnBusinessMinimalCaseSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPLocation on YLPBusiness success case with minimal set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.minimalResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.minimalResource];
    NSDictionary *expectedLocation = expectedResponse[@"location"];
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(business.location.displayAddress, expectedLocation[@"display_address"]);
        XCTAssertEqualObjects(business.location.crossStreets, nil);
        XCTAssertEqualObjects(business.location.postalCode, expectedLocation[@"postal_code"]);
        XCTAssertEqualObjects(business.location.coordinate, nil);
        XCTAssertEqualObjects(business.location.neighborhoods, nil);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testReviewOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPReview on YLPBusiness success case with full set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedReview = expectedResponse[@"reviews"][0];
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        YLPReview *actualReview = business.reviews[0];
        XCTAssertEqual(actualReview.rating, [expectedReview[@"rating"] doubleValue]);
        XCTAssertEqualObjects([actualReview.ratingImageURL absoluteString], expectedReview[@"rating_image_url"]);
        XCTAssertEqualObjects(actualReview.user.name, expectedReview[@"user"][@"name"]);
        XCTAssertEqualObjects([actualReview.user.imageURL absoluteString], expectedReview[@"user"][@"image_url"]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testGCOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPGiftCertificate on YLPBusiness success case with full set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedGCs = expectedResponse[@"gift_certificates"][0];
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        YLPGiftCertificate *actualGC = business.giftCertificates[0];
        XCTAssertEqualObjects([actualGC.URL absoluteString], expectedGCs[@"url"]);
        XCTAssertEqualObjects(actualGC.identifier, expectedGCs[@"id"]);
        XCTAssertEqualObjects(actualGC.identifier, expectedGCs[@"id"]);
        XCTAssertEqual([actualGC.options count], [expectedGCs[@"options"] count]);
        XCTAssertEqual(actualGC.unusedBalances, YLPBalanceTypeCredit);
        
        YLPGiftCertificateOption *actualOption = actualGC.options[0];
        XCTAssertEqual(actualOption.price, [expectedGCs[@"options"][0][@"price"] integerValue]);
        XCTAssertEqualObjects(actualOption.formattedPrice, expectedGCs[@"options"][0][@"formatted_price"]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testDealOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPDeal on YLPBusiness success case with full set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedDeal = expectedResponse[@"deals"][0];
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        YLPDeal *actualDeal = business.deals[0];
        XCTAssertEqualObjects([actualDeal.URL absoluteString], expectedDeal[@"url"]);
        XCTAssertEqualObjects(actualDeal.whatYouGet, expectedDeal[@"what_you_get"]);
        XCTAssertEqual([actualDeal.timeStart timeIntervalSince1970], [expectedDeal[@"time_start"] doubleValue]);
        XCTAssertEqual(actualDeal.isPopular, [expectedDeal[@"is_popular"] boolValue]);
        
        YLPDealOption *actualOption = actualDeal.options[0];
        NSDictionary *expectedOption = expectedDeal[@"options"][0];
        
        XCTAssertEqual(actualOption.originalPrice, [expectedOption[@"original_price"] integerValue]);
        XCTAssertEqualObjects(actualOption.title, expectedOption[@"title"]);
        XCTAssertEqualObjects([actualOption.purchaseURL absoluteString], expectedOption[@"purchase_url"]);
        XCTAssertEqual(actualOption.isQuantityLimited, [expectedOption[@"is_quantity_limited"] boolValue]);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}
@end
