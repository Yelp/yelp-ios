//
//  YLPSearch.h
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import "YLPBaseObject.h"

@class YLPRegion;
@class YLPBusiness;

NS_ASSUME_NONNULL_BEGIN

@interface YLPSearch : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, nullable, readonly) YLPRegion *region;
@property (nonatomic, readonly) NSArray<YLPBusiness *> *businesses;
@property (nonatomic, readonly) NSUInteger total;

@end

NS_ASSUME_NONNULL_END
