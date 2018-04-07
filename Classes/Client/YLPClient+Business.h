//
//  YLPClient+Business.h
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//
#import "YLPClient.h"

@class YLPBusiness;
@class YLPBusinessMatch;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPBusinessCompletionHandler)(YLPBusiness * _Nullable business, NSError * _Nullable error);
typedef void(^YLPBusinessMatchCompletionHandler)(NSArray<YLPBusinessMatch *>* _Nullable businesses, NSError * _Nullable error);

@interface YLPClient (Business)

- (void)businessWithId:(NSString *)businessId
     completionHandler:(YLPBusinessCompletionHandler)completionHandler;

- (void)findBusinessMatchesWithInfo:(NSDictionary *)info
     completionHandler:(YLPBusinessMatchCompletionHandler)completionHandler;

- (void)bestBusinessMatchWithInfo:(NSDictionary *)info
     completionHandler:(YLPBusinessMatchCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
