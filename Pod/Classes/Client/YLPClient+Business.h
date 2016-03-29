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

typedef void(^YLPBusinessCompletionHandler)(YLPBusiness * _Nullable business, NSError * _Nullable error);

@interface YLPClient (Business)

- (void)businessWithId:(NSString *)businessId
        completionHandler:(YLPBusinessCompletionHandler)completionHandler;

- (void)businessWithId:(NSString *)businessId
              countryCode:(nullable NSString *)countryCode
             languageCode:(nullable NSString *)languageCode
           languageFilter:(BOOL)languageFilter
              actionLinks:(BOOL)actionLinks
        completionHandler:(YLPBusinessCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
