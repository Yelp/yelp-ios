//
//  YLPClient+Search.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPSearch.h"
#import "YLPClient+Search.h"
#import "YLPCoordinate.h"
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Search)

- (void)searchWithLocation:(NSString *)location
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSDictionary *params = @{@"location": location};
    [self searchWithParams:params completionHandler:completionHandler];
}

- (void)searchWithLocation:(NSString *)location
               currentLatLong:(YLPCoordinate *)cll
                         term:(NSString *)term
                        limit:(NSUInteger)limit
                       offset:(NSUInteger)offset
                         sort:(YLPSortType)sort
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"location": location}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
             currentLatLong:(YLPCoordinate *)cll
                       term:(NSString *)term limit:(NSUInteger)limit
                     offset:(NSUInteger)offset
                       sort:(YLPSortType)sort
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"bounds": bounds.description}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [self searchWithBounds:bounds currentLatLong:nil term:nil limit:0 offset:0 sort:0 completionHandler:completionHandler];
}

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                    currentLatLong:(YLPCoordinate *)cll
                              term:(NSString *)term limit:(NSUInteger)limit
                            offset:(NSUInteger)offset
                              sort:(YLPSortType)sort
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"ll": geoCoordinate.description}];
    [self buildParamsAndCallSearch:params currentLatLong:cll term:term limit:limit offset:offset sort:sort completionHandler:completionHandler];
}

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordiante
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [self searchWithGeoCoordinate:geoCoordiante currentLatLong:nil term:nil limit:0 offset:0 sort:0 completionHandler:completionHandler];
}

- (void)buildParamsAndCallSearch:(NSMutableDictionary *)params
                  currentLatLong:(YLPCoordinate *)cll
                            term:(NSString *)term
                           limit:(NSUInteger)limit
                          offset:(NSUInteger)offset
                            sort:(YLPSortType)sort
               completionHandler:(YLPSearchCompletionHandler)completionHandler {
    
    [params addEntriesFromDictionary:[self paramsWithTerm:term currentLatLong:cll limit:limit offset:offset sort:sort]];
    [self searchWithParams:params completionHandler:completionHandler];
}

- (NSDictionary *)paramsWithTerm:(NSString *)term
                       currentLatLong:(YLPCoordinate *)cll
                                limit:(NSUInteger)limit
                               offset:(NSUInteger)offset
                                 sort:(YLPSortType)sort {
    
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

- (void)searchWithParams:(NSDictionary *)params
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
