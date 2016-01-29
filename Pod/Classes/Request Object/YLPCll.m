//
//  YLPCLL.m
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import "YLPCll.h"

@implementation YLPCll

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude {
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"%f,%f", self.latitude, self.longitude];
}

@end
