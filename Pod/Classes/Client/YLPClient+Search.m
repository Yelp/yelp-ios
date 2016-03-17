//
//  YLPClient+Search.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPSearch.h"
#import "YLPClient+Search.h"
#import "YLPCurrentLatLong.h"
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Search)

- (void)getSearchWithLocation:(NSString *)location
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSDictionary *params = @{@"location": location};
    [self getSearchWithParams:params completionHandler:completionHandler];
}

- (void)getSearchWithLocation:(NSString *)location
               currentLatLong:(YLPCurrentLatLong *)cll
                         term:(NSString *)term
                        limit:(NSUInteger)limit
                       offset:(NSUInteger)offset
                         sort:(NSUInteger)sort
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"location": location}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds
             currentLatLong:(YLPCurrentLatLong *)cll
                       term:(NSString *)term limit:(NSUInteger)limit
                     offset:(NSUInteger)offset
                       sort:(NSUInteger)sort
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"bounds": bounds.description}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [self getSearchWithBounds:bounds currentLatLong:nil term:nil limit:0 offset:0 sort:0 completionHandler:completionHandler];
}

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                    currentLatLong:(YLPCurrentLatLong *)cll
                              term:(NSString *)term limit:(NSUInteger)limit
                            offset:(NSUInteger)offset
                              sort:(NSUInteger)sort
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"ll": geoCoordinate.description}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordiante
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [self getSearchWithGeoCoordinate:geoCoordiante currentLatLong:nil term:nil limit:0 offset:0 sort:0 completionHandler:completionHandler];
}

- (void)buildParamsAndCallSearch:(NSMutableDictionary *)params
                  currentLatLong:(YLPCurrentLatLong *)cll
                            term:(NSString *)term
                           limit:(NSUInteger)limit
                          offset:(NSUInteger)offset
                            sort:(NSUInteger)sort
               completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [params addEntriesFromDictionary:[self paramsWithTerm:term currentLatLong:cll limit:limit offset:offset sort:sort]];
    [self getSearchWithParams:params completionHandler:completionHandler];
}

- (NSDictionary *)paramsWithTerm:(NSString *)term
                       currentLatLong:(YLPCurrentLatLong *)cll
                                limit:(NSUInteger)limit
                               offset:(NSUInteger)offset
                                 sort:(NSUInteger) sort {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if (cll) {
        params[@"cll"] = cll.description;
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
    
    return params;
}

- (NSURLRequest *)searchRequestWithParams:(NSDictionary *)params {
    return [self requestWithPath:@"/v2/search/" params:params];
}

- (void)getSearchWithParams:(NSDictionary *)params
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
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

@end
