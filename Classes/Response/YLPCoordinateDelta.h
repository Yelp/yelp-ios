//
//  YLPCoordinateDelta.h
//  Pods
//
//  Created by David Chen on 1/20/16.
//
//

#import "YLPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPCoordinateDelta : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) double latitudeDelta;
@property (nonatomic, readonly) double longitudeDelta;

@end

NS_ASSUME_NONNULL_END
