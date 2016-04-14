//
//  YLPGeoCoordinate.h
//  Pods
//
//  Created by David Chen on 1/25/16.
//
//

#import <Foundation/Foundation.h>

@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN

@interface YLPGeoCoordinate : NSObject

@property (nonatomic, copy, readonly) YLPCoordinate *coordinate;
@property (nonatomic, readonly) double accuracy;
@property (nonatomic, readonly) double altitude;
@property (nonatomic, readonly) double altitudeAccuracy;

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        accuracy:(double)accuracy
                        altitude:(double)altitude
                altitudeAccuracy:(double)altitudeAccuracy;

@end

NS_ASSUME_NONNULL_END