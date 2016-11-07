//
//  YLPRegion.h
//  Pods
//
//  Created by David Chen on 1/20/16.
//
//

#import "YLPBaseObject.h"

@class YLPCoordinate;
@class YLPCoordinateDelta;

NS_ASSUME_NONNULL_BEGIN

@interface YLPRegion : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) YLPCoordinateDelta *span;
@property (nonatomic, readonly) YLPCoordinate *center;

@end

NS_ASSUME_NONNULL_END
