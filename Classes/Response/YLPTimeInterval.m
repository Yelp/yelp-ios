//
//  YLPTimeInterval.m
//  YelpAPI
//
//  Created by Andry Rozdolsky on 3/2/17.
//
//

#import "YLPTimeInterval.h"

@implementation YLPTimeInterval


- (instancetype)initWithDictionary:(NSDictionary *)timeIntervalDict {
    if (self = [super init]) {
        _isOvernight = [timeIntervalDict[@"is_overnight"] boolValue];
        
        _dayOfWeek = [timeIntervalDict[@"day"] intValue];
        
        _startTime = timeIntervalDict[@"start"];
        _endTime = timeIntervalDict[@"end"];
    }
    return self;
}


@end
