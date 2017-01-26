//
//  YLPHour.h
//  Pods
//
//  Created by Grayson Sharpe on 1/26/17.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YLPDay) {
    YLPDayMonday,
    YLPDayTuesday,
    YLPDayWednesday,
    YLPDayThursday,
    YLPDayFriday,
    YLPDaySaturday,
    YLPDaySunday,
};

@class YLPUser;

NS_ASSUME_NONNULL_BEGIN

@interface YLPHour : NSObject

@property(nonatomic, readonly) YLPDay day;
@property (nonatomic, getter=isOvernight, readonly) BOOL overnight;
@property(nonatomic, readonly, copy) NSDate *start;
@property(nonatomic, readonly, copy) NSDate *end;

@end

NS_ASSUME_NONNULL_END
