//
//  YLPRegion.m
//  Pods
//
//  Created by David Chen on 1/20/16.
//
//

#import "YLPCoordinate.h"
#import "YLPCoordinateDelta.h"
#import "YLPRegion.h"
#import "YLPResponsePrivate.h"

@implementation YLPRegion
- (instancetype)initWithDictionary:(NSDictionary *)regionDict {
    if (self = [super init]) {
        _center = [[YLPCoordinate alloc] initWithLatitude:[regionDict[@"center"][@"latitude"] doubleValue] longitude:[regionDict[@"center"][@"longitude"] doubleValue]];
        _span = [[YLPCoordinateDelta alloc] initWithLatitudeDelta:[regionDict[@"span"][@"latitude_delta"] doubleValue] longitudeDelta:[regionDict[@"span"][@"longitude_delta"] doubleValue]];
    }
    
    return self;
}
@end
