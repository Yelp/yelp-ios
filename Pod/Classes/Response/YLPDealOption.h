//
//  YLPDealOption.h
//  Pods
//
//  Created by David Chen on 1/15/16.
//
//

NS_ASSUME_NONNULL_BEGIN

@interface YLPDealOption : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *formattedPrice;
@property (nonatomic, copy, readonly) NSString *formattedOriginalPrice;

@property (nonatomic, copy, readonly) NSURL *purchaseURL;

@property (nonatomic, copy, readonly) NSNumber *price;
@property (nonatomic, copy, readonly) NSNumber *originalPrice;
@property (nonatomic, copy, nullable, readonly) NSNumber *remainingCount;

@property (nonatomic, getter=isQuantityLimited, readonly) BOOL quantityLimited;

@end

NS_ASSUME_NONNULL_END