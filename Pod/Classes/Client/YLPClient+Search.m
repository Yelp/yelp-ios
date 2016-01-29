//
//  YLPClient+Search.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPSearch.h"
#import "YLPClient+Search.h"
#import "YLPCll.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Search)

- (void)getSearchWithLocation:(NSString *)location cll:(YLPCll *)cll term:(NSString *)term limit:(NSUInteger)limit offset:(NSUInteger)offset sort:(NSUInteger)sort completionHandler:(void (^)(YLPSearch *search, NSError *error))completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"location": location}];
    
    if (cll) {
        params[@"cll"] = cll.toString;
    }
    if (term) {
        params[@"term"] = term;
    }
    if (limit) {
        params[@"limit"] = [NSNumber numberWithInteger:limit];
    }
    if (offset) {
        params[@"offset"] = [NSNumber numberWithInteger:offset];
    }
    if (sort) {
        params[@"sort"] = [NSNumber numberWithInteger:sort];
    }
    
    [self getSearchWithParams:[NSDictionary dictionaryWithDictionary:params] completionHandler:completionHandler];
}

- (NSURLRequest *)searchRequestWithParams:(NSDictionary *)params {
    return [self requestWithPath:@"/v2/search/" params:params];
}

- (void)getSearchWithParams:(NSDictionary *)params completionHandler:(void (^)(YLPSearch *search, NSError *error))completionHandler {
    NSURLRequest *req = [self searchRequestWithParams:params];
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPSearch *search = [[YLPSearch alloc] initWithDictionary:responseDict];
            completionHandler(search, nil);
        }
        
    }];
    
}

- (void)getSearchWithLocation:(NSString *)location completionHandler:(void (^)(YLPSearch *search, NSError *error))completionHandler {
    NSDictionary *params = @{@"location": location};
    [self getSearchWithParams:params completionHandler:completionHandler];
}

@end
