//
//  YLPResponsePrivate.h
//  Pods
//
//  Created by David Chen on 1/11/16.
//
//
#import "YLPCategory.h"
#import "YLPBusiness.h"
#import "YLPLocation.h"
#import "YLPCoordinate.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPCategory ()
- (instancetype)initWithName:(NSString *)name alias:(NSString *)alias;
@end

@interface YLPBusiness ()
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;
@end

@interface YLPLocation()
- (instancetype)initWithDictionary:(NSDictionary *)locationDict;
@end

@interface YLPCoordinate()
- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;
@end

NS_ASSUME_NONNULL_END