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

@interface YLPClient (Search)

typedef void(^YLPSearchCompletionHandler)(YLPSearch *_Nullable search, NSError *_Nullable error);

- (void)getSearchWithLocation:(NSString *)location
               currentLatLong:(nullable YLPCurrentLatLong *)cll
                         term:(nullable NSString *)term
                        limit:(NSUInteger)limit
                       offset:(NSUInteger)offset
                         sort:(NSUInteger)sort
            completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)getSearchWithLocation:(NSString *)location
            completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds
             currentLatLong:(nullable YLPCurrentLatLong *)cll
                       term:(nullable NSString *)term
                      limit:(NSUInteger)limit
                     offset:(NSUInteger)offset
                       sort:(NSUInteger)sort
          completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds
          completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                    currentLatLong:(nullable YLPCurrentLatLong *)cll
                              term:(nullable NSString *)term
                             limit:(NSUInteger)limit
                            offset:(NSUInteger)offset
                              sort:(NSUInteger)sort
                 completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordiante
                 completionHandler:(YLPSearchCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END