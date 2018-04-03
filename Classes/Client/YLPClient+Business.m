//
//  YLPClient+Business.m
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//

#import "YLPClient+Business.h"
#import "YLPBusiness.h"
#import "YLPBusinessMatch.h"
#import "YLPClientPrivate.h"
#import "YLPResponsePrivate.h"

NSString *const BUSINESSES_PATH = @"/v3/businesses/";

@implementation YLPClient (Business)

- (NSURLRequest *)businessRequestWithId:(NSString *)businessId {
    NSString *businessPath = [BUSINESSES_PATH stringByAppendingString:businessId];
    return [self requestWithPath:businessPath];
}

- (void)businessWithId:(NSString *)businessId
     completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler {
    NSURLRequest *req = [self businessRequestWithId:businessId];
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPBusiness *business = [[YLPBusiness alloc] initWithDictionary:responseDict];
            completionHandler(business, nil);
        }
    }];
}

- (void)findBusinessMatchesWithInfo:(NSDictionary *)info
     completionHandler:(YLPBusinessMatchCompletionHandler)completionHandler {
    NSString *matchPath = [BUSINESSES_PATH stringByAppendingString:@"matches/lookup"];
    NSURLRequest *req = [self requestWithPath:matchPath params:info];
    
    [self businessMatchWithRequest:req completionHandler:completionHandler];
}

- (void)bestBusinessMatchWithInfo:(NSDictionary *)info
     completionHandler:(YLPBusinessMatchCompletionHandler)completionHandler {
    NSString *matchPath = [BUSINESSES_PATH stringByAppendingString:@"matches/best"];
    NSURLRequest *req = [self requestWithPath:matchPath params:info];
         
    [self businessMatchWithRequest:req completionHandler:completionHandler];
}

- (void)businessMatchWithRequest:(NSURLRequest *)req
     completionHandler:(YLPBusinessMatchCompletionHandler)completionHandler {
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            NSArray<NSDictionary *> *JSONArray = [responseDict objectForKey:@"businesses"];
            NSArray<YLPBusinessMatch *> *businessesJSONArray = JSONArray == nil
                ? [NSArray new]
                : [YLPBusinessMatch businessMatchesFromJSONArray:JSONArray];

            completionHandler(businessesJSONArray, nil);
        }
    }];
}

@end
