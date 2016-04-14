//
//  YLPDeal.h
//  Pods
//
//  Created by David Chen on 1/15/16.
//
//

#import <Foundation/Foundation.h>

@class YLPDealOption;

NS_ASSUME_NONNULL_BEGIN

@interface YLPDeal : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, copy, readonly) NSString *whatYouGet;
@property (nonatomic, copy, readonly) NSString *additionalRestrictions;
@property (nonatomic, copy, nullable, readonly) NSString *importantRestrictions;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *imageURL;

@property (nonatomic, copy, readonly) NSDate *timeStart;
@property (nonatomic, copy, nullable, readonly) NSDate *timeEnd;

@property (nonatomic, getter=isPopular, readonly) BOOL popular;

@property (nonatomic, copy, readonly) NSArray<YLPDealOption *> *options;

@end

NS_ASSUME_NONNULL_END