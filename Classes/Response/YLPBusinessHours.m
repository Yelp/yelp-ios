//
//  YLPBusinessHours.m
//  Pods
//
//  Created by Grayson Sharpe on 1/26/17.
//
//

#import "YLPBusinessHours.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusinessHours


- (instancetype)initWithDictionary:(NSDictionary *)hoursDict {
    if (self = [super init]) {
        _hours = [self.class hoursFromJSONArray:hoursDict[@"open"]];
        _openNow = [hoursDict[@"is_open_now"] boolValue];
        _type = hoursDict[@"hours_type"];
    }
    return self;
}

+ (NSArray *)hoursFromJSONArray:(NSArray *)hoursJSON {
    NSMutableArray<YLPHour *> *hours = [[NSMutableArray alloc] init];
    for (NSDictionary *hour in hoursJSON) {
        [hours addObject:[[YLPHour alloc] initWithDictionary:hour]];
    }
    return hours;
}


@end
