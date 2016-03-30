//
//  YLPGeoCoordinateTestCase.m
//  YelpAPI
//
//  Created by David Chen on 1/25/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YelpAPI/YLPGeoCoordinate.h>

@interface YLPGeoCoordinateTestCase : XCTestCase
@property (nonatomic, readonly) double expectedLatitude;
@property (nonatomic, readonly) double expectedLongitude;
@property (nonatomic, readonly) double expectedAccuracy;
@property (nonatomic, readonly) double expectedAltitude;
@property (nonatomic, readonly) double expectedAltitudeAccuracy;
@end

@implementation YLPGeoCoordinateTestCase

- (void)setUp {
    [super setUp];
    _expectedAccuracy = 1;
    _expectedAltitude = 12.2;
    _expectedAltitudeAccuracy = 1.1;
    
    _expectedLatitude = 30.1;
    _expectedLongitude = 90.3339;
}

- (void)testGeoCoordinateFullStrRepresentation{
    YLPGeoCoordinate *geoCoord = [[YLPGeoCoordinate alloc] initWithLatitude:self.expectedLatitude longitude:self.expectedLongitude accuracy:self.expectedAccuracy altitude:self.expectedAltitude altitudeAccuracy:self.expectedAltitudeAccuracy];
    NSString *expectedStr = [NSString stringWithFormat:@"%f,%f,%f,%f,%f", self.expectedLatitude, self.expectedLongitude, self.expectedAccuracy, self.expectedAltitude, self.expectedAltitudeAccuracy];
    XCTAssertEqualObjects(geoCoord.description, expectedStr);
}

@end
