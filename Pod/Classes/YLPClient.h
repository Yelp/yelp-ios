//
//  YLPClient.h
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import <Foundation/Foundation.h>

NSString *kAPIHost = @"api.yelp.com";

@interface YLPClient : NSURLRequest

@property NSArray *results;

- (instancetype)initWithConsumerKey: (NSString *)consumerKey consumerSecret:(NSString *)consumerSecret token:(NSString *)token tokenSecret:(NSString *)tokenSecret;

- (NSURLRequest *)requestWithPath: (NSString *)path;
- (NSURLRequest *)requestWithPath: (NSString *)path params:(NSDictionary *)params;

- (void)queryWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler;

@end
