//
//  YLPResponsePrivate.h
//  Pods
//
//  Created by David Chen on 1/11/16.
//
//
#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPReview.h"
#import "YLPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPCategory ()
- (instancetype)initWithName:(NSString *)name alias:(NSString *)alias;
@end

@interface YLPBusiness ()
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;
@end

@interface YLPLocation ()
- (instancetype)initWithDictionary:(NSDictionary *)locationDict;
@end

@interface YLPCoordinate ()
- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;
@end

@interface YLPUser ()
- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier imageURLString:(NSURL *)imageURLString;
@end

@interface YLPReview ()
- (instancetype)initWithDictionary:(NSDictionary *)reviewDict;
@end

NS_ASSUME_NONNULL_END