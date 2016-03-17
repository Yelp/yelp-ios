//
//  YLPClient+Business.m
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//

#import "YLPClient+Business.h"
#import "YLPBusiness.h"
#import "YLPClientPrivate.h"
#import "YLPResponsePrivate.h"

@implementation YLPClient (Business)

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId
                                 params:(NSDictionary *)params {
    
    NSString *businessPath = [@"/v2/business/" stringByAppendingString:businessId];
    return [self requestWithPath:businessPath params:params];
}

- (void)getBusinessWithId:(NSString *)businessId
        completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler {
    
    [self getBusinessWithId:businessId params:nil completionHandler:completionHandler];
}

- (void)getBusinessWithId:(NSString *)businessId
              countryCode:(NSString *)countryCode
             languageCode:(NSString *)languageCode
           languageFilter:(BOOL)languageFilter
              actionLinks:(BOOL)actionLinks
        completionHandler:(YLPBusinessCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{
                                    @"lang_filter": @(languageFilter),
                                    @"actionlinks": @(actionLinks)
                                    }];
    if (countryCode) {
        params[@"cc"] = countryCode;
    }
    if (languageCode) {
        params[@"lang"] = languageCode;
    }
    [self getBusinessWithId:businessId params:params completionHandler:completionHandler];
}

- (void)getBusinessWithId:(NSString *)businessId
                   params:(NSDictionary *)params
        completionHandler:(YLPBusinessCompletionHandler)completionHandler {
    
    NSURLRequest *req = [self businessRequestWithId:businessId params:params];
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPBusiness *business = [[YLPBusiness alloc] initWithDictionary:responseDict];
            completionHandler(business, nil);
        }
    }];
    
}
@end
