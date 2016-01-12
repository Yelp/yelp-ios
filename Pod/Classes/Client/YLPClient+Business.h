//
//  YLPClient+Business.h
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//
#import "YLPClient.h"

@class YLPBusiness;

NS_ASSUME_NONNULL_BEGIN

@interface YLPClient (Business)
- (void)getBusinessWithId:(NSString *)businessId completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;

- (void)getBusinessWithId:(NSString *)businessId countryCode:(nullable NSString *)countryCode languageCode:(nullable NSString *)languageCode languageFilter:(BOOL)languageFilter actionLinks:(BOOL)actionLinks completionHandler:(void (^)(YLPBusiness *business, NSError * error))completionHandler;
@end

NS_ASSUME_NONNULL_END
