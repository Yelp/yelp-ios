//
//  YLPQueryTestCase.m
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import <XCTest/XCTest.h>
#import "YLPCoordinate.h"
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"
#import "YLPQuery.h"
#import "YLPQueryPrivate.h"

@interface YLPQueryTestCase : XCTestCase
@end

@implementation YLPQueryTestCase

- (void)testQueryWithTerm {
    NSString *location = @"San Fransokyo";
    NSString *expectedTerm = @"some test term";
    double expectedLat = 30.1112322223;
    double expectedLong = -122.332322199980;
    YLPCoordinate *cll = [[YLPCoordinate alloc] initWithLatitude:expectedLat longitude:expectedLong];
    NSUInteger expectedLimit = 3;

    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location currentLatLong:cll];
    query.term = expectedTerm;
    query.limit = expectedLimit;

    NSDictionary *expectedParams = @{
        @"term": expectedTerm,
        @"limit": @(expectedLimit),
        @"location": location,
        @"cll": cll.description,
    };
    XCTAssertEqualObjects([query parameters], expectedParams);
}

- (void)testQueryWithBounds {
    YLPGeoBoundingBox *bounds = [[YLPGeoBoundingBox alloc] initWithSouthWestLongitude:1 southWestLatitude:1.2 northEastLatitude:1.3 northEastLongitude:1.5];
    YLPQuery *query = [[YLPQuery alloc] initWithBounds:bounds];

    NSDictionary *expectedParams = @{@"bounds": bounds.description};
    XCTAssertEqualObjects([query parameters], expectedParams);
}

- (void)testQueryWithGeoCoordinate {
    YLPGeoCoordinate *coordinate = [[YLPGeoCoordinate alloc] initWithLatitude:10 longitude:20 accuracy:15 altitude:12 altitudeAccuracy:1];
    YLPQuery *query = [[YLPQuery alloc] initWithGeoCoordinate:coordinate];

    NSDictionary *expectedParams = @{@"ll": coordinate.description};
    XCTAssertEqualObjects([query parameters], expectedParams);
}

- (void)testQueryWithCategoryFilter {
    NSString *location = @"San Fransokyo";
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location currentLatLong:nil];
    query.categoryFilter = @[@"bars", @"french"];

    NSDictionary *expectedParams = @{
        @"location": location,
        @"category_filter": @"bars,french",
    };
    XCTAssertEqualObjects([query parameters], expectedParams);
}

@end
