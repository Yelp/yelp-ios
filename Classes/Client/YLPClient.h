//
//  YLPClient.h
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import "YLPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYLPAPIHost;

@interface YLPClient : YLPBaseObject

- (instancetype)initWithConsumerKey:(NSString *)consumerKey
                     consumerSecret:(NSString *)consumerSecret
                              token:(NSString *)token
                        tokenSecret:(NSString *)tokenSecret NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
