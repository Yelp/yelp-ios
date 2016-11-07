//
//  YLPCoordinate.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPCoordinate : YLPBaseObject

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
