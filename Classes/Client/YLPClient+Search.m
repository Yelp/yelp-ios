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
#import "YLPQuery.h"
#import "YLPQueryPrivate.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Search)

- (void)searchWithLocation:(NSString *)location
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location currentLatLong:nil];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithLocation:(NSString *)location
               currentLatLong:(YLPCoordinate *)cll
                         term:(NSString *)term
                        limit:(NSUInteger)limit
                       offset:(NSUInteger)offset
                         sort:(YLPSortType)sort
            completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location currentLatLong:cll];
    query.term = term;
    query.limit = limit;
    query.offset = offset;
    query.sort = sort;
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
             currentLatLong:(YLPCoordinate *)cll
                       term:(NSString *)term limit:(NSUInteger)limit
                     offset:(NSUInteger)offset
                       sort:(YLPSortType)sort
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithBounds:bounds];
    query.currentLatLong = cll;
    query.term = term;
    query.limit = limit;
    query.offset = offset;
    query.sort = sort;
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
          completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithBounds:bounds];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                    currentLatLong:(YLPCoordinate *)cll
                              term:(NSString *)term limit:(NSUInteger)limit
                            offset:(NSUInteger)offset
                              sort:(YLPSortType)sort
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithGeoCoordinate:geoCoordinate];
    query.currentLatLong = cll;
    query.term = term;
    query.limit = limit;
    query.offset = offset;
    query.sort = sort;
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                 completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithGeoCoordinate:geoCoordinate];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (NSURLRequest *)searchRequestWithParams:(NSDictionary *)params {
    return [self requestWithPath:@"/v2/search/" params:params];
}

- (void)searchWithQuery:(YLPQuery *)query
      completionHandler:(YLPSearchCompletionHandler)completionHandler {
    NSDictionary *params = [query parameters];
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
