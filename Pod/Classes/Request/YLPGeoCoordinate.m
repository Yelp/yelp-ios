//
//  YLPGeoCoordinate.m
//  Pods
//
//  Created by David Chen on 1/25/16.
//
//

#import "YLPGeoCoordinate.h"
#import "YLPCommonPrivate.h"

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
    NSString *baseString = [self latLongString];
    
    if (self.accuracy) {
        baseString = [self accuracyDescription:baseString];
    }
    
    if (self.altitude) {
        baseString = [self altitudeDescription:baseString];
    }
    
    if (self.altitudeAccuracy) {
        baseString = [self altitudeAccuracyDescription:baseString];
    }
    
    return baseString;
}

- (NSString *)latLongString {
   return [NSString stringWithFormat:@"%f,%f", self.coordinate.latitude, self.coordinate.longitude];
}

- (NSString *)accuracyDescription:(NSString *)baseString {
    return [NSString stringWithFormat:@"%@,%f", baseString, self.accuracy];
}

- (NSString *)altitudeDescription:(NSString *)baseString {
    return [NSString stringWithFormat:@"%@,%f", baseString, self.altitude];
}

- (NSString *)altitudeAccuracyDescription:(NSString *)baseString {
    return [NSString stringWithFormat:@"%@,%f", baseString, self.altitudeAccuracy];
}

@end
