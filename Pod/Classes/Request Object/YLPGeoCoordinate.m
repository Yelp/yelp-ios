//
//  YLPGeoCoordinate.m
//  Pods
//
//  Created by David Chen on 1/25/16.
//
//

#import "YLPGeoCoordinate.h"

@implementation YLPGeoCoordinate

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude accuracy:(double)accuracy altitude:(double)altitude altitudeAccuracy:(double)altitudeAccuracy {
    
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
        _accuracy = accuracy;
        _altitude = altitude;
        _altitudeAccuracy = altitudeAccuracy;
    }
    
    return self;
    
}

- (NSString *)toString {
    NSString *baseStr = [self getLatLongStr];
    
    if (self.accuracy) {
        baseStr = [self addAccuracyToBaseStr:baseStr];
    }
    
    if (self.altitude) {
        baseStr = [self addAltitudeToBaseStr:baseStr];
    }
    
    if (self.altitudeAccuracy) {
        baseStr = [self addAltitudeAccuracyToBaseStr:baseStr];
    }
    
    return baseStr;
}

- (NSString *)getLatLongStr {
   return [NSString stringWithFormat:@"%f,%f", self.latitude, self.longitude];
}

- (NSString *)addAccuracyToBaseStr:(NSString *)baseStr {
    return [NSString stringWithFormat:@"%@,%f", baseStr, self.accuracy];
}

- (NSString *)addAltitudeToBaseStr:(NSString *)baseStr {
    return [NSString stringWithFormat:@"%@,%f", baseStr, self.altitude];
}

- (NSString *)addAltitudeAccuracyToBaseStr:(NSString *)baseStr {
    return [NSString stringWithFormat:@"%@,%f", baseStr, self.altitudeAccuracy];
}

@end
