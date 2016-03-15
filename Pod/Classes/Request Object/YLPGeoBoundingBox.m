//
//  GeoBoundingBox.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPGeoBoundingBox.h"
#import "YLPCoordinate.h"
#import "YLPResponsePrivate.h"

@implementation YLPGeoBoundingBox

- (instancetype)initWithSouthWestLongitude:(double)southWestLongitude
                         southWestLatitude:(double)southWestLatitude
                         northEastLatitude:(double)northEastLatitude
                        northEastLongitude:(double)northEastLongitude {
    
    if (self = [super init]) {
        _southWestCoordinate = [[YLPCoordinate alloc] initWithLatitude:southWestLatitude longitude:southWestLongitude];
        _northEastCoordinate = [[YLPCoordinate alloc] initWithLatitude:northEastLatitude longitude:northEastLongitude];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%f,%f|%f,%f", self.southWestCoordinate.latitude, self.southWestCoordinate.longitude, self.northEastCoordinate.latitude, self.northEastCoordinate.longitude];
}
@end
