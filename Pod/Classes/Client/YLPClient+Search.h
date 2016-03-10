//
//  YLPClient+Search.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPClient.h"

@class YLPCll;
@class YLPSearch;

NS_ASSUME_NONNULL_BEGIN

@interface YLPClient (Search)

- (void)getSearchWithLocation:(NSString *)location cll:(nullable YLPCll*)cll term:(nullable NSString *)term limit:(NSUInteger)limit offset:(NSUInteger)offset sort:(NSUInteger)sort completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

- (void)getSearchWithLocation:(NSString *)location completionHandler:(void (^)(YLPSearch * _Nullable search, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END