//
//  YLPBusinessHours.h
//  YelpAPI
//
//  Created by Andry Rozdolsky on 3/2/17.
//
//

#import <Foundation/Foundation.h>

@class YLPTimeInterval;

NS_ASSUME_NONNULL_BEGIN

@interface YLPOpenHours : NSObject

@property (nonatomic, getter=isOpenNow, readonly) BOOL openNow;

@property (nonatomic, readonly, copy) NSString *type;
@property (nonatomic, readonly, copy) NSArray<YLPTimeInterval *> *hours;

@end

NS_ASSUME_NONNULL_END


