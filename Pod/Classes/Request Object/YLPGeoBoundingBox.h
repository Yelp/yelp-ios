//
//  GeoBoundingBox.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

NS_ASSUME_NONNULL_BEGIN

@interface YLPGeoBoundingBox : NSObject

@property (nonatomic, readonly) double southWestLongitude;
@property (nonatomic, readonly) double southWestLatitude;

@property (nonatomic, readonly) double northEastLatitude;
@property (nonatomic, readonly) double northEastLongitude;

- (instancetype)initWithSouthWestLongitude:(double)southWestLongitude southWestLatitude:(double)southWestLatitude northEastLatitude:(double)northEastLatitude northEastLongitude:(double)northEastLongitude;

- (NSString *)toString;

@end

NS_ASSUME_NONNULL_END