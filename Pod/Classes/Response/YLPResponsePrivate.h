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
#import "YLPDeal.h"
#import "YLPDealOption.h"
#import "YLPGiftCertificate.h"
#import "YLPGiftCertificateOption.h"
#import "YLPLocation.h"
#import "YLPReview.h"
#import "YLPUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusiness ()
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;
@end

@interface YLPCategory ()
- (instancetype)initWithName:(NSString *)name alias:(NSString *)alias;
@end

@interface YLPCoordinate ()
- (instancetype)initWithLatitude:(double)latitude longitude:(double)longitude;
@end

@interface YLPDeal ()
- (instancetype)initWithDictionary:(NSDictionary *)deal;
@end

@interface YLPDealOption ()
- (instancetype)initWithDictionary:(NSDictionary *)dealOption;
@end

@interface YLPGiftCertificate ()
- (instancetype)initWithDictionary:(NSDictionary *)giftCertificates;
@end

@interface YLPGiftCertificateOption ()
- (instancetype)initWithPrice:(NSUInteger *)price formattedPrice:(NSString *)formattedPrice;
@end

@interface YLPLocation ()
- (instancetype)initWithDictionary:(NSDictionary *)locationDict;
@end

@interface YLPReview ()
- (instancetype)initWithDictionary:(NSDictionary *)reviewDict;
@end

@interface YLPUser ()
- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier imageURLString:(NSURL *)imageURLString;
@end

NS_ASSUME_NONNULL_END