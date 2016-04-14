//
//  YLPGiftCertificate.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import <Foundation/Foundation.h>

@class YLPGiftCertificateOption;

typedef NS_ENUM(NSInteger, YLPBalanceType) {
    YLPBalanceTypeCash,
    YLPBalanceTypeCredit
};

NS_ASSUME_NONNULL_BEGIN

@interface YLPGiftCertificate : NSObject
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, readonly) YLPBalanceType unusedBalances;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *imageURL;

@property (nonatomic, copy, readonly) NSArray<YLPGiftCertificateOption *> *options;
@end

NS_ASSUME_NONNULL_END