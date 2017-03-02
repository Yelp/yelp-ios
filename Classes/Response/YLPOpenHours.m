//
//  YLPBusinessHours.m
//  YelpAPI
//
//  Created by Andry Rozdolsky on 3/2/17.
//
//

#import "YLPOpenHours.h"
#import "YLPTimeInterval.h"
#import "YLPResponsePrivate.h"

@implementation YLPOpenHours

- (instancetype)initWithDictionary:(NSDictionary *)openHoursDict {
    if (self = [super init]) {
        
        _openNow =  [openHoursDict[@"is_open_now"] boolValue];
        
        _type = openHoursDict[@"hours_type"];
        _hours = [self.class timeIntervalsFromJSONArray:openHoursDict[@"open"]];

    }
    return self;
}

+ (NSArray *)timeIntervalsFromJSONArray:(NSArray *)timeIntervalsJSON {
    NSMutableArray *mutableTimeIntervals = [[NSMutableArray alloc] init];
    for (NSDictionary *timeInterval in timeIntervalsJSON) {
        [mutableTimeIntervals addObject:[[YLPTimeInterval alloc] initWithDictionary:timeInterval]];
    }
    return mutableTimeIntervals;
}



@end
