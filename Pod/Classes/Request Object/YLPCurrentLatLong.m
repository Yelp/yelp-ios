//
//  YLPCLL.m
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import "YLPCurrentLatLong.h"
#import "YLPCoordinate.h"
#import "YLPResponsePrivate.h"

@implementation YLPCurrentLatLong

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude {
    if (self = [super init]) {
        _coordinate = [[YLPCoordinate alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%f,%f", self.coordinate.latitude, self.coordinate.longitude];
}

@end
