//
//  GeoBoundingBox.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPBaseObject.h"

@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN

@interface YLPGeoBoundingBox : YLPBaseObject

@property (nonatomic, copy, readonly) YLPCoordinate *southwestCoordinate;
@property (nonatomic, copy, readonly) YLPCoordinate *northeastCoordinate;

- (instancetype)initWithSouthWestLongitude:(double)southwestLongitude
                         southWestLatitude:(double)southwestLatitude
                         northEastLatitude:(double)northeastLatitude
                        northEastLongitude:(double)northeastLongitude NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
