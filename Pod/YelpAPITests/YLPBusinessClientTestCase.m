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
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPClient+Business.h>
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

- (NSDictionary *)loadExpectedResponse {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *filePath = [bundle pathForResource:@"business_response" ofType:@"json"];
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:nil];
}
@end
