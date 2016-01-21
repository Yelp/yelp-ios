//
//  YLPRegion.h
//  Pods
//
//  Created by David Chen on 1/20/16.
//
//
@class YLPCoordinate;
@class YLPCoordinateDelta;

NS_ASSUME_NONNULL_BEGIN

@interface YLPRegion : NSObject

@property (nonatomic, copy, readonly) YLPCoordinateDelta *span;
@property (nonatomic, copy, readonly) YLPCoordinate *center;

@end

NS_ASSUME_NONNULL_END