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

// ll, location, bounds

- (void)getSearchWithLocation:(NSString *)location currentLatLong:(nullable YLPCurrentLatLong *)cll term:(nullable NSString *)term limit:(NSUInteger)limit offset:(NSUInteger)offset sort:(NSUInteger)sort completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithLocation:(NSString *)location completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds currentLatLong:(nullable YLPCurrentLatLong *)cll term:(nullable NSString *)term limit:(NSUInteger)limit offset:(NSUInteger)offset sort:(NSUInteger)sort completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithBounds:(YLPGeoBoundingBox *)bounds completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate currentLatLong:(nullable YLPCurrentLatLong *)cll term:(nullable NSString *)term limit:(NSUInteger)limit offset:(NSUInteger)offset sort:(NSUInteger)sort completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordiante completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END