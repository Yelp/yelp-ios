//
//  YLPGiftCertificate.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//
NS_ASSUME_NONNULL_BEGIN

@interface YLPGiftCertificate : NSObject
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *currencyCode;
@property (nonatomic, copy, readonly) NSString *unusedBalances;

@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *imageURL;

@property (nonatomic, copy, readonly) NSArray *options;
@end

NS_ASSUME_NONNULL_END