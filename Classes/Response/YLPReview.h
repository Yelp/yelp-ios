//
//  YLPReview.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPBaseObject.h"

@class YLPUser;

NS_ASSUME_NONNULL_BEGIN

@interface YLPReview : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property(nonatomic, readonly, copy) NSString *excerpt;

@property(nonatomic, readonly, copy) NSDate *timeCreated;

@property(nonatomic, readonly) double rating;

@property(nonatomic, readonly) YLPUser *user;

@end

NS_ASSUME_NONNULL_END
