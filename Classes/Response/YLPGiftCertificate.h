//
//  YLPGiftCertificate.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPBaseObject.h"

@class YLPGiftCertificateOption;

typedef NS_ENUM(NSInteger, YLPBalanceType) {
    YLPBalanceTypeCash,
    YLPBalanceTypeCredit
};

NS_ASSUME_NONNULL_BEGIN

@interface YLPGiftCertificate : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, readonly) YLPBalanceType unusedBalances;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *imageURL;

@property (nonatomic, copy, readonly) NSArray<YLPGiftCertificateOption *> *options;
@end

NS_ASSUME_NONNULL_END
