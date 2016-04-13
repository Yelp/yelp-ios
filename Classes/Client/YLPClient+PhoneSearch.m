//
//  YLPClient+PhoneSearch.m
//  Pods
//
//  Created by David Chen on 1/19/16.
//
//

#import "YLPClient+PhoneSearch.h"
#import "YLPClientPrivate.h"
#import "YLPPhoneSearch.h"
#import "YLPResponsePrivate.h"


@implementation YLPClient (PhoneSearch)

- (NSURLRequest *)businessRequestWithParams:(NSDictionary *)params {

    
    NSString *phoneSearchPath = @"/v2/phone_search/";
    return [self requestWithPath:phoneSearchPath params:params];
}

- (void)businessWithPhoneNumber:(NSString *)phoneNumber
                 completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler {
    
    [self businessWithParams:@{@"phone": phoneNumber} completionHandler:completionHandler];
}

- (void)businessWithPhoneNumber:(NSString *)phoneNumber
                       countryCode:(NSString *)countryCode
                          category:(NSString *)category
                 completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"phone": phoneNumber}];
    
    if (countryCode) {
        params[@"cc"] = countryCode;
    }
    if (category) {
        params[@"category"] = category;
    }
    [self businessWithParams:[NSDictionary dictionaryWithDictionary:params] completionHandler:completionHandler];
    
}

- (void)businessWithParams:(NSDictionary *)params
         completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler {
    
    NSURLRequest *req = [self businessRequestWithParams:params];
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPPhoneSearch *phoneSearch = [[YLPPhoneSearch alloc] initWithDictionary:responseDict];
            completionHandler(phoneSearch, nil);
        }
        
    }];
    
}

@end
