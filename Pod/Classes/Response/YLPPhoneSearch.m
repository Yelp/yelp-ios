//
//  YLPPhoneSearch.m
//  Pods
//
//  Created by David Chen on 1/19/16.
//
//

#import "YLPBusiness.h"
#import "YLPPhoneSearch.h"
#import "YLPRegion.h"
#import "YLPResponsePrivate.h"

@implementation YLPPhoneSearch

- (instancetype)initWithDictionary:(NSDictionary *)phoneSearchDict {
    if (self = [super init]) {
        [self setBusinesses:phoneSearchDict[@"businesses"]];
        _region = [[YLPRegion alloc] initWithDictionary:phoneSearchDict[@"region"]];
        _total = [phoneSearchDict[@"total"] integerValue];
    }
    
    return self;
}

- (void)setBusinesses:(NSArray *)businesses {
    NSMutableArray *mutableBusinesses = [[NSMutableArray alloc] init];
    
    for (id business in businesses) {
        [mutableBusinesses addObject:[[YLPBusiness alloc] initWithDictionary:business]];
    }
    _businesses = [NSArray arrayWithArray:mutableBusinesses];
}

@end
