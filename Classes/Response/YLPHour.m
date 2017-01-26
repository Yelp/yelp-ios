//
//  YLPHour.m
//  Pods
//
//  Grayson Sharpe on 1/26/17.
//
//

#import "YLPHour.h"
#import "YLPUser.h"
#import "YLPResponsePrivate.h"

@implementation YLPHour

- (instancetype)initWithDictionary:(NSDictionary *)hourDict {
    if (self = [super init]) {
        _day = [hourDict[@"day"] intValue];
        _overnight = hourDict[@"is_overnight"];
        
        NSString *startTimeString = [[NSString alloc] initWithFormat:@"%@:%@", [hourDict[@"start"] substringToIndex:2], [hourDict[@"start"] substringFromIndex:2]];
        _start = [self.class dateFromTimestamp:startTimeString];
        
        NSString *endTimeString = [[NSString alloc] initWithFormat:@"%@:%@", [hourDict[@"end"] substringToIndex:2], [hourDict[@"end"] substringFromIndex:2]];
        _end = [self.class dateFromTimestamp:endTimeString];            
    }
    
    return self;
}

+ (NSDate *)dateFromTimestamp:(NSString *)timestamp {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
        dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    });

    return [dateFormatter dateFromString:timestamp];
}

@end
