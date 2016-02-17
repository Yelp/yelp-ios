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
        if ([giftCertificate[@"unused_balances"] isEqual: @"CREDIT"]) {
            _unusedBalances = YLPBalanceTypeCredit;
        } else {
            _unusedBalances = YLPBalanceTypeCash;
        }
        
        _URL = [NSURL URLWithString:giftCertificate[@"url"]];
        _imageURL = [NSURL URLWithString:giftCertificate[@"image_url"]];
        _options = [self.class optionsWithJSONArray:giftCertificate[@"options"]];
    }
    
    return self;
}

+ (NSArray *)optionsWithJSONArray:(NSArray *)options {
    NSMutableArray *mutableOptions = [[NSMutableArray alloc] init];
    for (NSDictionary *option in options) {
        [mutableOptions addObject:[[YLPGiftCertificateOption alloc] initWithPrice:[option[@"price"] integerValue] formattedPrice:option[@"formatted_price"]]];
    }
    return mutableOptions;
}
@end
