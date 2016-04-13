//
//  YLPDeal.m
//  Pods
//
//  Created by David Chen on 1/15/16.
//
//

#import "YLPDeal.h"
#import "YLPDealOption.h"
#import "YLPResponsePrivate.h"

@implementation YLPDeal

- (instancetype)initWithDictionary:(NSDictionary *)deal {
    if (self = [super init]) {
        _identifier = deal[@"id"];
        _title = deal[@"title"];
        _whatYouGet = deal[@"what_you_get"];
        _currencyCode = deal[@"currency_code"];
        _importantRestrictions = deal[@"important_restrictions"];
        _additionalRestrictions = deal[@"additional_restrictions"];
        
        _timeStart = [NSDate dateWithTimeIntervalSince1970:[deal[@"time_start"] doubleValue]];
        _timeEnd = deal[@"time_end"] ? [NSDate dateWithTimeIntervalSince1970:[deal[@"time_end"] doubleValue]] : nil;
        
        _popular = [deal[@"is_popular"] boolValue];
        
        _URL = [NSURL URLWithString:deal[@"url"]];
        _imageURL = [NSURL URLWithString:deal[@"image_url"]];
        _options = [self.class optionsWithJSONArray:deal[@"options"]];
    }
    
    return self;
}

+ (NSArray *)optionsWithJSONArray:(NSArray *)options {
    NSMutableArray *mutableOptions = [[NSMutableArray alloc] init];
    for (NSDictionary *option in options) {
        [mutableOptions addObject:[[YLPDealOption alloc] initWithDictionary:option]];
    }
    return mutableOptions;
}

@end
