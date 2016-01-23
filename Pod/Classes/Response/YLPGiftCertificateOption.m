//
//  YLPGiftCertificateOption.m
//  Pods
//
//  Created by David Chen on 1/14/16.
//
//

#import "YLPGiftCertificateOption.h"

@implementation YLPGiftCertificateOption
- (instancetype)initWithPrice:(NSUInteger)price formattedPrice:(NSString *)formattedPrice {
    if (self = [super init]) {
        _price = price;
        _formattedPrice = formattedPrice;
    }
    return self;
}
@end
