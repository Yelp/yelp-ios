//
//  YLPClient+Search.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPClient.h"

@class YLPSearch;

NS_ASSUME_NONNULL_BEGIN

@interface YLPClient (Search)

- (void)getBusinessWithTerm:(nullable NSString *)phoneNumber countryCode:(nullable NSString *)countryCode category:(nullable NSString *)category completionHandler:(nullable void (^)(YLPPhoneSearch * _Nullable phoneSearch, NSError * _Nullable error))completionHandler;

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber completionHandler:(nullable void (^)(YLPPhoneSearch * _Nullable phoneSearch, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END