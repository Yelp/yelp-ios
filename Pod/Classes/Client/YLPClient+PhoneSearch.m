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

- (NSURLRequest *)businessRequestWithPhoneNumber:(NSString *)phoneNumber params:(NSDictionary *)params {
    NSString *phoneSearchPath = [@"/v2/phone_search/" stringByAppendingString:phoneNumber];
    
    return [self requestWithPath:phoneSearchPath params:params];
}

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber completionHandler:(void (^)(YLPPhoneSearch *phoneSearch, NSError *error))completionHandler {
    [self getBusinessWithPhoneNumber:phoneNumber params:nil completionHandler:completionHandler];
    
}

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber countryCode:(NSString *)countryCode category:(NSString *)category completionHandler:(void (^)(YLPPhoneSearch *phoneSearch, NSError *error))completionHandler {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (countryCode) {
        params[@"cc"] = countryCode;
    }
    if (category) {
        params[@"category"] = category;
    }
    [self getBusinessWithPhoneNumber:phoneNumber params:[NSDictionary dictionaryWithDictionary:params] completionHandler:completionHandler];
    
}

- (void)getBusinessWithPhoneNumber:(NSString *)phoneNumber params:(NSDictionary *)params completionHandler:(void (^)(YLPPhoneSearch *phoneSearch, NSError *error))completionHandler {
    
    NSURLRequest *req = [self businessRequestWithPhoneNumber:phoneNumber params:params];
    
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
