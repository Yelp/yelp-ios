//
//  YLPSearch.m
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import "YLPSearch.h"
#import "YLPResponsePrivate.h"

@implementation YLPSearch
- (instancetype)initWithDictionary:(NSDictionary *)searchDict {
    if (self = [super init]) {
        _total = [searchDict[@"total"] intValue];
        [self setBusinesses:searchDict[@"businesses"]];
        _region = [[YLPRegion alloc] initWithDictionary:searchDict[@"region"]];
    }
    
    return self;
}

- (void)setBusinesses:(NSArray *)businesses {
    NSMutableArray<YLPBusiness *> *mutableBusinesses = [[NSMutableArray alloc] init];
    for (NSDictionary *business in businesses) {
        [mutableBusinesses addObject:[[YLPBusiness alloc] initWithDictionary:business]];
    }
    _businesses = mutableBusinesses;
}
@end
