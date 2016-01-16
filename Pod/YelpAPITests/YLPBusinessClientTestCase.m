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
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPCategory.h>
#import <YelpAPI/YLPClient+Business.h>
#import <YelpAPI/YLPCoordinate.h>
#import <YelpAPI/YLPGiftCertificate.h>
#import <YelpAPI/YLPGiftCertificateOption.h>
#import <YelpAPI/YLPDeal.h>
#import <YelpAPI/YLPDealOption.h>
#import <YelpAPI/YLPLocation.h>
#import <YelpAPI/YLPReview.h>
#import <YelpAPI/YLPUser.h>
#import <XCTest/XCTest.h>
#import "YLPClientTestCaseBase.h"

@interface YLPBusinessClientTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (BusinessClientTest)

- (void)getBusinessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;

@end

@implementation YLPBusinessClientTestCase

- (id)mockBusinessRequestWithAllArgs {
    id mockBusinessRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockBusinessRequestWithAllArgs getBusinessWithId:[OCMArg any] params:[OCMArg any] completionHandler:[OCMArg any]]);
    return mockBusinessRequestWithAllArgs;
}

//TODO: Add some unit testing for parameter passing
- (void)testNullParams {
    [self.client getBusinessWithId:@"gary-danko" countryCode:@"" languageCode:@"" languageFilter:NO actionLinks:nil completionHandler:^(YLPBusiness *business, NSError *error) {}];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" countryCode:nil languageCode:nil languageFilter:nil actionLinks:nil completionHandler:^(YLPBusiness *business, NSError *error) {}];
}
- (void)testBusinessRequestWithId {
    id mockBusinessRequestWithIdWithAllArgs = [self mockBusinessRequestWithAllArgs];
    [self.client getBusinessWithId:@"bogusBusinessId" completionHandler:^(YLPBusiness *business, NSError *error) {}];
    
    OCMVerify([mockBusinessRequestWithIdWithAllArgs getBusinessWithId:@"bogusBusinessId" params:nil completionHandler:[OCMArg any]]);
}

- (void)testBusinessRequestResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Business query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(error, nil);
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
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSString *expectedAlias = expectedResponse[@"categories"][0][1];
    NSString *expectedName = expectedResponse[@"categories"][0][0];
    
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
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
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSDictionary *expectedLocation = expectedResponse[@"location"];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
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
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"minimum_business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSDictionary *expectedLocation = expectedResponse[@"location"];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
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
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSDictionary *expectedReview = expectedResponse[@"reviews"][0];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqual(((YLPReview *)business.reviews[0]).rating, [expectedReview[@"rating"] doubleValue]);
        XCTAssertEqualObjects([((YLPReview *)business.reviews[0]).ratingImageURL absoluteString], expectedReview[@"rating_image_url"]);
        XCTAssertEqualObjects(((YLPReview *)business.reviews[0]).user.name, expectedReview[@"user"][@"name"]);
        XCTAssertEqualObjects([((YLPReview *)business.reviews[0]).user.imageURL absoluteString], expectedReview[@"user"][@"image_url"]);
        [expectation fulfill];
        
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testGCOnBusinessSetCorrectly {
    XCTestExpectation *expectation = [self expectationWithDescription:@"YLPGiftCertificate on YLPBusiness success case with full set of response keys."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSDictionary *expectedGCs = expectedResponse[@"gift_certificates"][0];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        YLPGiftCertificate *actualGC = business.giftCertificates[0];
        XCTAssertEqualObjects([actualGC.URL absoluteString], expectedGCs[@"url"]);
        XCTAssertEqualObjects(actualGC.identifier, expectedGCs[@"id"]);
        XCTAssertEqualObjects(actualGC.identifier, expectedGCs[@"id"]);
        XCTAssertEqual([actualGC.options count], [expectedGCs[@"options"] count]);
        
        YLPGiftCertificateOption *actualOption = actualGC.options[0];
        XCTAssertEqualObjects(actualOption.price, expectedGCs[@"options"][0][@"price"]);
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
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"business_response.json",self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse];
    NSDictionary *expectedDeal = expectedResponse[@"deals"][0];
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        YLPDeal *actualDeal = business.deals[0];
        XCTAssertEqualObjects([actualDeal.URL absoluteString], expectedDeal[@"url"]);
        XCTAssertEqualObjects(actualDeal.whatYouGet, expectedDeal[@"what_you_get"]);
        XCTAssertEqual([actualDeal.timeStart timeIntervalSince1970], [expectedDeal[@"time_start"] doubleValue]);
        XCTAssertEqual(actualDeal.isPopular, [expectedDeal[@"is_popular"] boolValue]);
        
        YLPDealOption *actualOption = actualDeal.options[0];
        NSDictionary *expectedOption = expectedDeal[@"options"][0];
        
        XCTAssertEqualObjects(actualOption.originalPrice, expectedOption[@"original_price"]);
        XCTAssertEqualObjects(actualOption.title, expectedOption[@"title"]);
        XCTAssertEqualObjects([actualOption.purchaseURL absoluteString], expectedOption[@"purchase_url"]);
        XCTAssertEqual(actualOption.isQuantityLimited, [expectedOption[@"is_quantity_limited"] boolValue]);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (NSDictionary *)loadExpectedResponse {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *filePath = [bundle pathForResource:@"business_response" ofType:@"json"];
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:nil error:nil];
}
@end
