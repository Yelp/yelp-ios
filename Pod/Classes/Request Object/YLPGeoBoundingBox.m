//
//  GeoBoundingBox.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPGeoBoundingBox.h"

@implementation YLPGeoBoundingBox

- (instancetype)initWithSouthWestLongitude:(double)southWestLongitude southWestLatitude:(double)southWestLatitude northEastLatitude:(double)northEastLatitude northEastLongitude:(double)northEastLongitude {
    if (self = [super init]) {
        _southWestLatitude = southWestLatitude;
        _southWestLongitude = southWestLongitude;
        
        _northEastLatitude = northEastLatitude;
        _northEastLongitude = northEastLongitude;
    }
    
    return self;
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"%f,%f|%f,%f", self.southWestLatitude, self.southWestLongitude, self.northEastLatitude, self.northEastLongitude];
}
@end
