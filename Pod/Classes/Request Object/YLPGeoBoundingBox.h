//
//  GeoBoundingBox.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//
@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN

@interface YLPGeoBoundingBox : NSObject

@property (nonatomic, copy, readonly) YLPCoordinate *southWestCoordinate;
@property (nonatomic, copy, readonly) YLPCoordinate *northEastCoordinate;

- (instancetype)initWithSouthWestLongitude:(double)southWestLongitude
                         southWestLatitude:(double)southWestLatitude
                         northEastLatitude:(double)northEastLatitude
                        northEastLongitude:(double)northEastLongitude;

@end

NS_ASSUME_NONNULL_END