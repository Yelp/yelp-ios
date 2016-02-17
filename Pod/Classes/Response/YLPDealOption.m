//
//  YLPDealOption.m
//  Pods
//
//  Created by David Chen on 1/15/16.
//
//

#import "YLPDealOption.h"

@implementation YLPDealOption

- (instancetype)initWithDictionary:(NSDictionary *)option {
    if (self = [super init]) {
        _title = option[@"title"];
        _purchaseURL = [NSURL URLWithString:option[@"purchase_url"]];
        _price = [option[@"price"] integerValue];
        _formattedPrice = option[@"formatted_price"];
        _originalPrice = [option[@"original_price"] integerValue];
        
        _formattedOriginalPrice = option[@"formatted_original_price"];
        _quantityLimited = [option[@"is_quantity_limited"] boolValue];
        _remainingCount = option[@"remaining_count"];
        
    }
    return self;
}


@end
