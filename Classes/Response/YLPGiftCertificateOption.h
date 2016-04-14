//
//  YLPGiftCertificateOption.h
//  Pods
//
//  Created by David Chen on 1/14/16.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPGiftCertificateOption : NSObject

@property (nonatomic, readonly) NSUInteger price;
@property (nonatomic, copy, readonly) NSString *formattedPrice;

@end

NS_ASSUME_NONNULL_END