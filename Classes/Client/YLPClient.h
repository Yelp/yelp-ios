//
//  YLPClient.h
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kYLPAPIHost;

@interface YLPClient : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (void)authorizeWithAppId:(NSString *)appId
                    secret:(NSString *)secret
         completionHandler:(void (^)(YLPClient *_Nullable client, NSError *_Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
