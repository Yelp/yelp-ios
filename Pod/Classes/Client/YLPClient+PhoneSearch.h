//
//  YLPClient+PhoneSearch.h
//  Pods
//
//  Created by David Chen on 1/19/16.
//
//
#import "YLPClient.h"

@class YLPPhoneSearch;

NS_ASSUME_NONNULL_BEGIN

@interface YLPClient (PhoneSearch)

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber countryCode:(nullable NSString *)countryCode category:(nullable NSString *)category completionHandler:(void (^)(YLPPhoneSearch * _Nullable phoneSearch, NSError * _Nullable error))completionHandler;

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(YLPPhoneSearch * _Nullable phoneSearch, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END