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
        _businesses = [self.class businessesFromJSONArray:phoneSearchDict[@"businesses"]];
        if (phoneSearchDict[@"region"] != [NSNull null]) {
            _region = [[YLPRegion alloc] initWithDictionary:phoneSearchDict[@"region"]];
        }
        _total = [phoneSearchDict[@"total"] integerValue];
    }
    
    return self;
}

+ (NSArray *)businessesFromJSONArray:(NSArray *)businessesJSON {
    NSMutableArray *mutableBusinessesJSON = [[NSMutableArray alloc] init];
    
    for (NSDictionary *business in businessesJSON) {
        [mutableBusinessesJSON addObject:[[YLPBusiness alloc] initWithDictionary:business]];
    }
    
    return mutableBusinessesJSON;
}

@end
