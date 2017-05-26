//
//  YLPAutocompleteClientTestCase.m
//  YelpAPI
//
//  Created by Kenny Dang on 5/14/17.
//
//

#import <OCMock/OCMock.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <XCTest/XCTest.h>
#import "YLPAutocomplete.h"
#import "YLPClient+Autocomplete.h"
#import "YLPCoordinate.h"
#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPResponsePrivate.h"
#import "YLPClientTestCaseBase.h"

@interface YLPAutocompleteTestCase : YLPClientTestCaseBase
@end

@interface YLPClient (AutocompleteClientTest)
- (NSURLRequest *)autoCompleteRequestWithParams:(NSDictionary *)params;
@end

@implementation YLPAutocompleteTestCase

- (void)setUp {
    [super setUp];
    self.defaultResource = @"autocomplete_response.json";
}

- (void)testFetchAutocompleteRequest {
    NSDictionary *params = @{@"text": @"bogusSearchTerm",
                             @"latitude": @37.761357,
                             @"longitude": @-122.424377};
    
    NSURLRequest *request = [self.client autoCompleteRequestWithParams:params];
    
    XCTAssertTrue(request.URL.path, @"v3/autocomplete?longitude=-122.424377&text=bogusSearchTerm&latitude=37.761357");
}

- (void)testFetchAutocompleteRequestWithLocale {
    NSDictionary *params = @{@"text": @"bogusSearchTerm",
                             @"latitude": @37.761357,
                             @"longitude": @-122.424377,
                             @"locale": @"en_US"};
    
    NSURLRequest *request = [self.client autoCompleteRequestWithParams:params];

    XCTAssertTrue(request.URL.path, @"v3/autocomplete?longitude=-122.424377&text=bogusSearchTerm&latitude=37.761357&locale=en_US");

}

- (void) testFetchAutocompleteResultsForBusinesses {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Autocomplete query test, success case."];

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedFirstBiz = expectedResponse[@"businesses"][0];
    NSDictionary *expectedSecondBiz = expectedResponse[@"businesses"][1];
    NSDictionary *expectedThirdBiz = expectedResponse[@"businesses"][2];

    double latitude = 37.7613570;
    double longitude = -122.4243770;
    
    YLPCoordinate *myCoordinate = [[YLPCoordinate alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.client fetchAutocompleteSuggestionsWithTerm:@"Bakery" coordinate:myCoordinate locale:nil completionHandler:^(YLPAutocomplete * _Nullable autocomplete, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        NSMutableArray *businesses = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in autocomplete.businesses) {
            [businesses addObject:dict];
        }
        
        XCTAssertEqualObjects([businesses[0] identifier], expectedFirstBiz[@"id"]);
        XCTAssertEqualObjects([businesses[1] identifier], expectedSecondBiz[@"id"]);
        XCTAssertEqualObjects([businesses[2] identifier], expectedThirdBiz[@"id"]);
        
        XCTAssertEqualObjects([businesses[0] name], expectedFirstBiz[@"name"]);
        XCTAssertEqualObjects([businesses[1] name], expectedSecondBiz[@"name"]);
        XCTAssertEqualObjects([businesses[2] name], expectedThirdBiz[@"name"]);

        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testFetchAutocompleteResultsForCategories {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Autocomplete query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedFirstCategory = expectedResponse[@"categories"][0];
    NSDictionary *expectedSecondCategory = expectedResponse[@"categories"][1];
    NSDictionary *expectedThirdCategory = expectedResponse[@"categories"][2];
    
    double latitude = 37.7613570;
    double longitude = -122.4243770;
    
    YLPCoordinate *myCoordinate = [[YLPCoordinate alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.client fetchAutocompleteSuggestionsWithTerm:@"Bakery" coordinate:myCoordinate locale:nil completionHandler:^(YLPAutocomplete * _Nullable autocomplete, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        NSMutableArray *categories = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in autocomplete.categories) {
            [categories addObject:dict];
        }
        
        XCTAssertEqualObjects([categories[0] alias], expectedFirstCategory[@"alias"]);
        XCTAssertEqualObjects([categories[1] alias], expectedSecondCategory[@"alias"]);
        XCTAssertEqualObjects([categories[2] alias], expectedThirdCategory[@"alias"]);
        
        XCTAssertEqualObjects([categories[0] name], expectedFirstCategory[@"title"]);
        XCTAssertEqualObjects([categories[1] name], expectedSecondCategory[@"title"]);
        XCTAssertEqualObjects([categories[2] name], expectedThirdCategory[@"title"]);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testFetchAutocompleteResultsForSearchTermsWithCoordinates {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Autocomplete query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedFirstText = expectedResponse[@"terms"][0];
    NSDictionary *expectedSecondText = expectedResponse[@"terms"][1];
    NSDictionary *expectedThirdText = expectedResponse[@"terms"][2];
    
    double latitude = 37.7613570;
    double longitude = -122.4243770;
    
    YLPCoordinate *myCoordinate = [[YLPCoordinate alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.client fetchAutocompleteSuggestionsWithTerm:@"Bakery" coordinate:myCoordinate locale:nil completionHandler:^(YLPAutocomplete * _Nullable autocomplete, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        NSMutableArray *terms = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in autocomplete.terms) {
            [terms addObject:dict];
        }
        
        XCTAssertEqualObjects(terms[0], expectedFirstText);
        XCTAssertEqualObjects(terms[1], expectedSecondText);
        XCTAssertEqualObjects(terms[2], expectedThirdText);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void) testFetchAutoCompleteResultsForSearchTerms {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Autocomplete query test, success case."];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:kYLPAPIHost];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(self.defaultResource, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    NSDictionary *expectedResponse = [self loadExpectedResponse:self.defaultResource];
    NSDictionary *expectedFirstText = expectedResponse[@"terms"][0];
    NSDictionary *expectedSecondText = expectedResponse[@"terms"][1];
    NSDictionary *expectedThirdText = expectedResponse[@"terms"][2];
    
    [self.client fetchAutocompleteSuggestionsWithTerm:@"Bakery" coordinate:nil locale:nil completionHandler:^(YLPAutocomplete * _Nullable autocomplete, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        
        NSMutableArray *terms = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in autocomplete.terms) {
            [terms addObject:dict];
        }
        
        XCTAssertEqualObjects(terms[0], expectedFirstText);
        XCTAssertEqualObjects(terms[1], expectedSecondText);
        XCTAssertEqualObjects(terms[2], expectedThirdText);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
