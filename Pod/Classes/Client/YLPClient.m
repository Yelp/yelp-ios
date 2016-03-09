//
//  YLPClient.m
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import <Foundation/Foundation.h>
#import <TDOAuth/TDOAuth.h>
#import "YLPClient.h"
#import "YLPClientPrivate.h"

NSString *const kYLPAPIHost = @"api.yelp.com";

@implementation YLPClient

- (instancetype)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret token:(NSString *)token tokenSecret:(NSString *)tokenSecret {
    if (self = [super init]) {
        _consumerKey = consumerKey;
        _consumerSecret = consumerSecret;
        _token = token;
        _tokenSecret = tokenSecret;
    }
    return self;
}

- (NSURLRequest *)requestWithPath:(NSString *)path {
    return [self requestWithPath:path params:nil];
}

- (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params {
    return [TDOAuth URLRequestForPath:path
                        GETParameters:params
                               scheme:@"https"
                                 host:kYLPAPIHost
                          consumerKey:self.consumerKey
                       consumerSecret:self.consumerSecret
                          accessToken:self.token
                          tokenSecret:self.tokenSecret];
}

- (void)queryWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            completionHandler(responseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
}

@end