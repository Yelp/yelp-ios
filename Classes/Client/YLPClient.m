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
NSString *const kYLPErrorDomain = @"com.yelp.YelpAPI.ErrorDomain";

@implementation YLPClient

- (instancetype)initWithConsumerKey:(NSString *)consumerKey
                     consumerSecret:(NSString *)consumerSecret
                              token:(NSString *)token
                        tokenSecret:(NSString *)tokenSecret {
    
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

- (void)queryWithRequest:(NSURLRequest *)request
       completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseJSON;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        // This case handles cases where the request was processed by the API, thus
        // resulting in a JSON object being passed back into `data`.
        if (!error) {
            responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        }
        
        if (!error && httpResponse.statusCode == 200) {
            completionHandler(responseJSON, nil);
        } else {
            // If a request fails due to systematic errors with the API then an NSError will be returned.
            error = error ? error : [NSError errorWithDomain:kYLPErrorDomain code:httpResponse.statusCode userInfo:responseJSON];
            completionHandler(nil, error);
        }
    }] resume];
}

@end