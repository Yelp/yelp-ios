//
//  YLPGeoCoordinate.m
//  Pods
//
//  Created by David Chen on 1/25/16.
//
//

#import "YLPGeoCoordinate.h"
#import "YLPCoordinate.h"

@implementation YLPGeoCoordinate

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        accuracy:(double)accuracy
                        altitude:(double)altitude
                altitudeAccuracy:(double)altitudeAccuracy {
    
    if (self = [super init]) {
        _coordinate = [[YLPCoordinate alloc] initWithLatitude:latitude longitude:longitude];
        _accuracy = accuracy;
        _altitude = altitude;
        _altitudeAccuracy = altitudeAccuracy;
    }
    
    return self;
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%f,%f,%f,%f,%f",
            self.coordinate.latitude,
            self.coordinate.longitude,
            self.accuracy,
            self.altitude,
            self.altitudeAccuracy];
}

@end
