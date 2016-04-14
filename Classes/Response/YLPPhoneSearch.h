//
//  YLPPhoneSearch.h
//  Pods
//
//  Created by David Chen on 2/19/16.
//
//

#import <Foundation/Foundation.h>

@class YLPBusiness;
@class YLPRegion;

NS_ASSUME_NONNULL_BEGIN

@interface YLPPhoneSearch : NSObject

@property (nonatomic, readonly) NSArray <YLPBusiness *> *businesses;
@property (nonatomic, readonly) NSUInteger total;

@property (nonatomic, nullable, readonly) YLPRegion *region;

@end

NS_ASSUME_NONNULL_END
