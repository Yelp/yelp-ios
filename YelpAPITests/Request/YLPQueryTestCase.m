//
//  YLPQueryTestCase.m
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import <XCTest/XCTest.h>
#import "YLPCoordinate.h"
#import "YLPQuery.h"
#import "YLPQueryPrivate.h"

@interface YLPQueryTestCase : XCTestCase
@end

@implementation YLPQueryTestCase

- (void)testQueryWithTerm {
    NSString *location = @"San Fransokyo";
    NSString *expectedTerm = @"some test term";
    NSUInteger expectedLimit = 3;

    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location];
    query.term = expectedTerm;
    query.limit = expectedLimit;

    NSDictionary *expectedParams = @{
        @"term": expectedTerm,
        @"limit": @(expectedLimit),
        @"location": location,
    };
    XCTAssertEqualObjects([query parameters], expectedParams);
}

- (void)testQueryWithCoordinate {
    double expectedLat = 30.1112322223;
    double expectedLong = -122.332322199980;
    YLPCoordinate *coordinate = [[YLPCoordinate alloc] initWithLatitude:expectedLat longitude:expectedLong];
    YLPQuery *query = [[YLPQuery alloc] initWithCoordinate:coordinate];

    NSDictionary *expectedParams = @{
        @"latitude": @(expectedLat),
        @"longitude": @(expectedLong),
    };
    XCTAssertEqualObjects([query parameters], expectedParams);
}

- (void)testQueryWithCategoryFilter {
    NSString *location = @"San Fransokyo";
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location];
    query.categoryFilter = @[@"bars", @"french"];

    NSDictionary *expectedParams = @{
        @"location": location,
        @"categories": @"bars,french",
    };
    XCTAssertEqualObjects([query parameters], expectedParams);
}

@end
