//
//  YLPClient.h
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import <Foundation/Foundation.h>

extern NSString *kYLPAPIHost = @"api.yelp.com";

@interface YLPClient : NSObject

- (instancetype)initWithConsumerKey: (NSString *)consumerKey consumerSecret:(NSString *)consumerSecret token:(NSString *)token tokenSecret:(NSString *)tokenSecret;

@end
