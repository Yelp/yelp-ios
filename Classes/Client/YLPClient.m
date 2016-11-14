//
//  YLPClient.m
//  Pods
//
//  Created by David Chen on 12/7/15.
//
//

#import <Foundation/Foundation.h>
#import "YLPClient.h"
#import "YLPClientPrivate.h"

NSString *const kYLPAPIHost = @"api.yelp.com";
NSString *const kYLPErrorDomain = @"com.yelp.YelpAPI.ErrorDomain";

@interface YLPClient ()
@property (strong, nonatomic) NSString *accessToken;
@end

@implementation YLPClient

- (instancetype)init {
    return nil;
}

- (instancetype)initWithAccessToken:(NSString *)accessToken {
    if (self = [super init]) {
        _accessToken = accessToken;
    }
    return self;
}

- (NSURLRequest *)requestWithPath:(NSString *)path {
    return [self requestWithPath:path params:nil];
}

- (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https";
    urlComponents.host = kYLPAPIHost;
    urlComponents.path = path;

    NSArray *queryItems = [YLPClient queryItemsForParams:params];
    if (queryItems.count > 0) {
        urlComponents.queryItems = queryItems;
    }

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponents.URL];
    request.HTTPMethod = @"GET";
    NSString *authHeader = [NSString stringWithFormat:@"Bearer %@", self.accessToken];
    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];

    return request;
}

- (void)queryWithRequest:(NSURLRequest *)request
       completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler {
    [YLPClient queryWithRequest:request completionHandler:completionHandler];
}

#pragma mark Request utilities

+ (void)queryWithRequest:(NSURLRequest *)request
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

+ (NSArray<NSURLQueryItem *> *)queryItemsForParams:(NSDictionary<NSString *, id> *)params {
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *name in params) {
        NSString *value = [params[name] description];
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:name value:value];
        [queryItems addObject:queryItem];
    }
    return queryItems;
}

+ (NSCharacterSet *)URLEncodeAllowedCharacters {
    // unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
    NSMutableCharacterSet *allowedCharacters = [[NSMutableCharacterSet alloc] init];
    [allowedCharacters addCharactersInRange:NSMakeRange((NSUInteger)'A', 26)];
    [allowedCharacters addCharactersInRange:NSMakeRange((NSUInteger)'a', 26)];
    [allowedCharacters addCharactersInRange:NSMakeRange((NSUInteger)'0', 10)];
    [allowedCharacters addCharactersInString:@"-._~"];
    return allowedCharacters;
}

#pragma mark Authorization

+ (NSURLRequest *)authRequestWithAppId:(NSString *)appId secret:(NSString *)secret {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https";
    urlComponents.host = kYLPAPIHost;
    urlComponents.path = @"/oauth2/token";

    NSCharacterSet *allowedCharacters = [self URLEncodeAllowedCharacters];
    NSString *body = [NSString stringWithFormat:@"grant_type=client_credentials&client_id=%@&client_secret=%@",
                      [appId stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters],
                      [secret stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponents.URL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = bodyData;
    [request setValue:[NSString stringWithFormat:@"%zd", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    return request;
}

+ (void)authorizeWithAppId:(NSString *)appId
                    secret:(NSString *)secret
         completionHandler:(void (^)(YLPClient *client, NSError *error))completionHandler {
    NSURLRequest *request = [self authRequestWithAppId:appId secret:secret];
    [self queryWithRequest:request completionHandler:^(NSDictionary *jsonResponse, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSString *accessToken = jsonResponse[@"access_token"];
            YLPClient *client = [[YLPClient alloc] initWithAccessToken:accessToken];
            completionHandler(client, nil);
        }
    }];
}

@end
