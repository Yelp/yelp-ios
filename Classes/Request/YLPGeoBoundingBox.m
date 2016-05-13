//
//  GeoBoundingBox.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPGeoBoundingBox.h"
#import "YLPCoordinate.h"

@implementation YLPGeoBoundingBox

- (instancetype)initWithSouthWestLongitude:(double)southwestLongitude
                         southWestLatitude:(double)southwestLatitude
                         northEastLatitude:(double)northeastLatitude
                        northEastLongitude:(double)northeastLongitude {
    
    if (self = [super init]) {
        _southwestCoordinate = [[YLPCoordinate alloc] initWithLatitude:southwestLatitude longitude:southwestLongitude];
        _northeastCoordinate = [[YLPCoordinate alloc] initWithLatitude:northeastLatitude longitude:northeastLongitude];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%f,%f|%f,%f", self.southwestCoordinate.latitude, self.southwestCoordinate.longitude, self.northeastCoordinate.latitude, self.northeastCoordinate.longitude];
}
@end
