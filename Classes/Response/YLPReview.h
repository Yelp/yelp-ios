//
//  YLPReview.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import <Foundation/Foundation.h>

@class YLPUser;

NS_ASSUME_NONNULL_BEGIN

@interface YLPReview : NSObject

@property(nonatomic, readonly, copy) NSString *identifier;
@property(nonatomic, readonly, copy) NSString *excerpt;

@property(nonatomic, readonly, copy) NSDate *timeCreated;

@property(nonatomic, readonly) double rating;

@property(nonatomic, readonly, copy) NSURL *ratingImageURL;
@property(nonatomic, readonly, copy) NSURL *ratingImageSmallURL;
@property(nonatomic, readonly, copy) NSURL *ratingImageLargeURL;

@property(nonatomic, readonly, copy) YLPUser *user;

@end

NS_ASSUME_NONNULL_END