//
//  YLPCLL.h
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

NS_ASSUME_NONNULL_BEGIN

@interface YLPCll : NSObject

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;
- (NSString *)toString;

@end

NS_ASSUME_NONNULL_END