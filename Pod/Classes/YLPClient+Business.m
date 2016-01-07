//
//  YLPClient+Business.m
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//

#import "YLPClient+Business.h"

@interface YLPClient (Business)
// Defined in YLPClient.m
- (NSURLRequest *)requestWithPath:(NSString *)path;
- (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params;
- (void)queryWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSDictionary *responseDict, NSError *error))completionHandler;

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId params:(NSDictionary *)params;
- (void)getBusinessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;
@end

@implementation YLPClient (Business)

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId params:(NSDictionary *)params {
    NSString *businessPath = [@"/v2/business/" stringByAppendingString:businessId];
    return [self requestWithPath:businessPath params:params];
}

- (NSMutableDictionary *)removeNullValuesFromParams:(NSMutableDictionary *)params {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for(id key in params)
        if ([params objectForKey:key] != [NSNull null])
            [result setObject:[params objectForKey: key] forKey:key];
    return result;
}

- (void)getBusinessWithId:(NSString *)businessId completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler {
    [self getBusinessWithId:businessId params:nil completionHandler:completionHandler];
}

- (void)getBusinessWithId:(NSString *)businessId countryCode:(NSString *)countryCode languageCode:(NSString *)languageCode languageFilter:(bool)languageFilter actionLinks:(bool)actionLinks completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler {
    NSDictionary *params = @{
                            @"cc": countryCode,
                            @"lang": languageCode,
                            @"lang_filter": @(languageFilter),
                            @"actionlinks": @(actionLinks)
                            };
    [self getBusinessWithId:businessId params:params completionHandler:completionHandler];
}

- (void)getBusinessWithId:(NSString *)businessId params:(NSDictionary *)params completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler {
    NSURLRequest *req = [self businessRequestWithId:businessId params:params];
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error)
            completionHandler(nil, error);
        else {
            YLPBusiness *business = [[YLPBusiness alloc] initWithDictionary:responseDict];
            completionHandler(business, nil);
        }
    }];
    
}

@end
