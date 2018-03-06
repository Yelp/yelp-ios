//
//  YLPTimeInterval.h
//  YelpAPI
//
//  Created by Andry Rozdolsky on 3/2/17.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPTimeInterval : NSObject

@property (nonatomic, readonly, copy) NSString *startTime;
@property (nonatomic, readonly, copy) NSString *endTime;
@property (nonatomic, readonly) int dayOfWeek;
@property (nonatomic, readonly) bool isOvernight;


@end

NS_ASSUME_NONNULL_END
