//
//  YLPPhoneSearch.h
//  Pods
//
//  Created by David Chen on 1/19/16.
//
//
#import "YLPRegion.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPPhoneSearch : NSObject

@property (nonatomic, copy, readonly) NSArray *businesses;
@property (nonatomic, readonly) NSUInteger total;

//TODO: convert to YLPRegion object
@property (nonatomic, copy, nullable, readonly) YLPRegion *region;

@end

NS_ASSUME_NONNULL_END