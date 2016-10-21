//
//  YLPResponsePrivate.h
//  Pods
//
//  Created by David Chen on 1/11/16.
//
//
#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPCoordinateDelta.h"
#import "YLPLocation.h"
#import "YLPRegion.h"
#import "YLPReview.h"
#import "YLPSearch.h"
#import "YLPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusiness ()
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;
@end

@interface YLPCategory ()
- (instancetype)initWithName:(NSString *)name alias:(NSString *)alias;
- (instancetype)initWithDictionary:(NSDictionary *)categoryDict;
@end

@interface YLPCoordinateDelta ()
- (instancetype)initWithLatitudeDelta:(double)latitudeDelta longitudeDelta:(double)longitudeDelta;
@end

@interface YLPLocation ()
- (instancetype)initWithDictionary:(NSDictionary *)locationDict coordinate:(nullable YLPCoordinate *)coordinate;
@end

@interface YLPRegion ()
- (instancetype)initWithDictionary:(NSDictionary *)regionDict;
@end

@interface YLPReview ()
- (instancetype)initWithDictionary:(NSDictionary *)reviewDict;
@end

@interface YLPSearch ()
- (instancetype)initWithDictionary:(NSDictionary *)searchDict;
@end

@interface YLPUser ()
- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier imageURLString:(NSURL *)imageURLString;
@end

NS_ASSUME_NONNULL_END
