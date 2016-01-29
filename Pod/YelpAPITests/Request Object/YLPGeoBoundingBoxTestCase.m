//
//  YLPGeoBoundingBoxTestCase.m
//  YelpAPI
//
//  Created by David Chen on 1/25/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YelpAPI/YLPGeoBoundingBox.h>

@interface YLPGeoBoundingBoxTestCase : XCTestCase

@end

@implementation YLPGeoBoundingBoxTestCase

- (void)testBoxReturnsExpectedString{
    double swLat = 10.2;
    double swLong = 20.12;
    
    double neLat = 11.4;
    double neLong = 11.68;
    
    YLPGeoBoundingBox *geoBoundingBox = [[YLPGeoBoundingBox alloc] initWithSouthWestLongitude:swLong southWestLatitude:swLat northEastLatitude:neLat northEastLongitude:neLong];
    NSString *expected = [NSString stringWithFormat:@"%f,%f|%f,%f", swLat, swLong, neLat, neLong];
    XCTAssertEqualObjects([geoBoundingBox toString], expected);
}

@end
