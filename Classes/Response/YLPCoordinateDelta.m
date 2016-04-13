//
//  YLPCoordinateDelta.m
//  Pods
//
//  Created by David Chen on 1/20/16.
//
//

#import "YLPCoordinateDelta.h"

@implementation YLPCoordinateDelta

- (instancetype)initWithLatitudeDelta:(double)latitudeDelta longitudeDelta:(double)longitudeDelta {
    if (self = [super init]) {
        _latitudeDelta = latitudeDelta;
        _longitudeDelta = longitudeDelta;
    }
    return self;
}

@end
