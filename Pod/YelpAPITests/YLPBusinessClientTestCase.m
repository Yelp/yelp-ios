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
@property YLPClient *realClient;
@end

@interface YLPClient (BusinessClientTest)

- (NSMutableDictionary *)removeNullValuesFromParams:(NSMutableDictionary *)params;
- (void)getBusinessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;
@end

@implementation YLPBusinessClientTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (instancetype)mockBusinessRequestWithAllArgs {
    id mockBusinessRequestWithAllArgs = OCMPartialMock(self.client);
    OCMStub([mockBusinessRequestWithAllArgs getBusinessWithId:[OCMArg any] params:[OCMArg any] completionHandler:[OCMArg any]]);
    return mockBusinessRequestWithAllArgs;
}

//TODO: Add some unit testing for parameter passing

- (void)testRemoveNullFromParams {
    NSMutableDictionary *testParams = [[NSMutableDictionary alloc] initWithDictionary:@{@"nil": [NSNull null], @"notnil": @"somestring"}];
    XCTAssertEqualObjects([self.client removeNullValuesFromParams:testParams], @{@"notnil": @"somestring"});
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
    
    NSDictionary *expected_response = [self loadExpectedResponse];
    
    [self.client getBusinessWithId:@"gary-danko-san-francisco" completionHandler:^(YLPBusiness *business, NSError *error) {
        XCTAssertEqualObjects(error, nil);
        //String assignment testing
        XCTAssertEqualObjects(business.id, @"gary-danko-san-francisco");
        //URL assignment testing
        XCTAssertEqualObjects(business.url, [expected_response objectForKey:@"url"]);
        //Number assignment testing
        XCTAssertEqualObjects(business.rating, [expected_response objectForKey:@"rating"]);
        [expectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (NSDictionary *)loadExpectedResponse {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *filePath = [bundle pathForResource:@"business_response" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
}
@end
