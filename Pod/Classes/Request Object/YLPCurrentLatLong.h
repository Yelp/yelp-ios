//
//  YLPCLL.h
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN
@interface YLPCurrentLatLong : NSObject

@property (nonatomic, copy, readonly) YLPCoordinate *coordinate;

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END