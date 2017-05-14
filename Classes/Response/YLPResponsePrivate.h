//
//  YLPResponsePrivate.h
//  Pods
//
//  Created by David Chen on 1/11/16.
//
//
#import "YLPAutocomplete.h"
#import "YLPBusiness.h"
#import "YLPBusinessReviews.h"
#import "YLPCategory.h"
#import "YLPLocation.h"
#import "YLPReview.h"
#import "YLPSearch.h"
#import "YLPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPAutocomplete ()
- (instancetype)initWithDictionary:(NSDictionary *)autocompleteDict;
@end

@interface NSDictionary<KeyType, ObjectType> (YLPUtils)
- (nullable ObjectType)ylp_objectMaybeNullForKey:(KeyType)key;
@end

@interface YLPBusiness ()
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;
- (instancetype)initWithAutocompleteDictionary:(NSDictionary *)autocompleteDict;
@end

@interface YLPBusinessReviews ()
- (instancetype)initWithDictionary:(NSDictionary *)reviewsDict;
@end

@interface YLPCategory ()
- (instancetype)initWithName:(NSString *)name alias:(NSString *)alias;
- (instancetype)initWithDictionary:(NSDictionary *)categoryDict;
@end

@interface YLPLocation ()
- (instancetype)initWithDictionary:(NSDictionary *)locationDict coordinate:(nullable YLPCoordinate *)coordinate;
@end

@interface YLPReview ()
- (instancetype)initWithDictionary:(NSDictionary *)reviewDict;
@end

@interface YLPSearch ()
- (instancetype)initWithDictionary:(NSDictionary *)searchDict;
@end

@interface YLPUser ()
- (instancetype)initWithDictionary:(NSDictionary *)userDict;
@end

NS_ASSUME_NONNULL_END
