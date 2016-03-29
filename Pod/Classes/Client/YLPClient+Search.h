//
//  YLPClient+Search.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPClient.h"

@class YLPCurrentLatLong;
@class YLPGeoBoundingBox;
@class YLPGeoCoordinate;
@class YLPSearch;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPSearchCompletionHandler)(YLPSearch *_Nullable search, NSError *_Nullable error);

@interface YLPClient (Search)

- (void)searchWithLocation:(NSString *)location
               currentLatLong:(nullable YLPCurrentLatLong *)cll
                         term:(nullable NSString *)term
                        limit:(NSUInteger)limit
                       offset:(NSUInteger)offset
                         sort:(NSUInteger)sort
            completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithLocation:(NSString *)location
            completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
             currentLatLong:(nullable YLPCurrentLatLong *)cll
                       term:(nullable NSString *)term
                      limit:(NSUInteger)limit
                     offset:(NSUInteger)offset
                       sort:(NSUInteger)sort
          completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
          completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                    currentLatLong:(nullable YLPCurrentLatLong *)cll
                              term:(nullable NSString *)term
                             limit:(NSUInteger)limit
                            offset:(NSUInteger)offset
                              sort:(NSUInteger)sort
                 completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordiante
                 completionHandler:(YLPSearchCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END