//
//  YLPGiftCertificate.m
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPGiftCertificate.h"
#import "YLPGiftCertificateOption.h"
#import "YLPResponsePrivate.h"

@implementation YLPGiftCertificate
- (instancetype)initWithDictionary:(NSDictionary *)giftCertificate {
    if (self = [super init]) {
        _identifier = giftCertificate[@"id"];
        _currencyCode = giftCertificate[@"currency_code"];
        _unusedBalances = giftCertificate[@"unused_balances"];
        
        _URL = [NSURL URLWithString:giftCertificate[@"url"]];
        _imageURL = [NSURL URLWithString:giftCertificate[@"image_url"]];
        [self setOptions:giftCertificate[@"options"]];
    }
    
    return self;
}

- (void)setOptions:(NSDictionary *)options {
    NSMutableArray *mutableOptions = [[NSMutableArray alloc] init];
    for (id option in options) {
        [mutableOptions addObject:[[YLPGiftCertificateOption alloc] initWithPrice:option[@"price"] formattedPrice:option[@"formatted_price"]]];
    }
    
    _options = [NSArray arrayWithArray:mutableOptions];
}
@end
