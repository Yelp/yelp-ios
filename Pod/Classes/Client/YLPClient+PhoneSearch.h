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

typedef void(^YLPPhoneSearchCompletionHandler)(YLPPhoneSearch * _Nullable phoneSearch, NSError * _Nullable error);

@interface YLPClient (PhoneSearch)

- (void)businessWithPhoneNumber:(NSString *)phoneNumber
                       countryCode:(nullable NSString *)countryCode
                          category:(nullable NSString *)category
                 completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler;

- (void)businessWithPhoneNumber:(NSString *)phoneNumber
                 completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END