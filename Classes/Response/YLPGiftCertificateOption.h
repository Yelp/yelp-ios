//
//  YLPGiftCertificateOption.h
//  Pods
//
//  Created by David Chen on 1/14/16.
//
//

#import "YLPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPGiftCertificateOption : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly) NSUInteger price;
@property (nonatomic, copy, readonly) NSString *formattedPrice;

@end

NS_ASSUME_NONNULL_END
