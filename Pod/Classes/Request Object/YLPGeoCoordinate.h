//
//  YLPGeoCoordinate.h
//  Pods
//
//  Created by David Chen on 1/25/16.
//
//

NS_ASSUME_NONNULL_BEGIN

@interface YLPGeoCoordinate : NSObject

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) double accuracy;
@property (nonatomic, readonly) double altitude;
@property (nonatomic, readonly) double altitudeAccuracy;

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude accuracy:(double)accuracy altitude:(double)altitude altitudeAccuracy:(double)altitudeAccuracy;

- (NSString *)toString;

@end

NS_ASSUME_NONNULL_END