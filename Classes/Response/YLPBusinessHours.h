//
//  YLPBusinessHours.h
//  Pods
//
//  Created by Grayson Sharpe on 1/26/17.
//
//

#import <Foundation/Foundation.h>

@class YLPHour;

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusinessHours : NSObject

@property (nonatomic, readonly) NSArray<YLPHour *> *hours;
@property (nonatomic, getter=isOpenNow, readonly) BOOL openNow;
@property (nonatomic, readonly, copy) NSString *type;


@end

NS_ASSUME_NONNULL_END
