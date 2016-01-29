//
//  YLPSearch.h
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

@class YLPRegion;
@class YLPBusiness;

NS_ASSUME_NONNULL_BEGIN

@interface YLPSearch : NSObject

@property (nonatomic, copy, readonly)YLPRegion *region;
@property (nonatomic, copy, readonly)NSArray<YLPBusiness *> *businesses;
@property (nonatomic, readonly)NSUInteger total;

@end

NS_ASSUME_NONNULL_END