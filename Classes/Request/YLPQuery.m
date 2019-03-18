//
//  YLPQuery.m
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import "YLPQuery.h"
#import "YLPQueryPrivate.h"
#import "YLPCoordinate.h"

@implementation YLPQuery

- (instancetype)initWithLocation:(NSString *)location {
    if (self = [super init]) {
        _mode = YLPSearchModeLocation;
        _location = [location copy];
    }
    return self;
}

- (instancetype)initWithCoordinate:(YLPCoordinate *)coordinate {
    if (self = [super init]) {
        _mode = YLPSearchModeCoordinate;
        _coordinate = coordinate;
    }
    return self;
}

- (NSArray<NSString *> *)categoryFilter {
    return _categoryFilter ?: @[];
}

- (NSString *)sortParameter {
    switch (self.sort) {
        case YLPSortTypeBestMatched:
            return @"best_match";
        case YLPSortTypeHighestRated:
            return @"rating";
        case YLPSortTypeDistance:
            return @"distance";
        case YLPSortTypeMostReviewed:
            return @"review_count";
    }
}

- (NSDictionary *)parameters {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    switch (self.mode) {
        case YLPSearchModeLocation:
            params[@"location"] = self.location;
            break;
        case YLPSearchModeCoordinate:
            params[@"latitude"] = @(self.coordinate.latitude);
            params[@"longitude"] = @(self.coordinate.longitude);
            break;
    }

    if (self.term) {
        params[@"term"] = self.term;
    }
    if (self.price) {
        params[@"price"] = self.price;
    }
    if (self.locale) {
        params[@"locale"] = self.locale;
    }
    if (self.limit) {
        params[@"limit"] = @(self.limit);
    }
    if (self.openAt > 0) {
        params[@"open_at"] = @(self.openAt);
    }
    if (self.offset) {
        params[@"offset"] = @(self.offset);
    }
    if (self.sort != YLPSortTypeBestMatched) {
        params[@"sort_by"] = [self sortParameter];
    }
    if (self.categoryFilter.count > 0) {
        params[@"categories"] = [self.categoryFilter componentsJoinedByString:@","];
    }
    if (self.radiusFilter > 0) {
        params[@"radius"] = @(@(round(self.radiusFilter)).intValue);
    }
    if (self.dealsFilter && self.hotAndNewFilter) {
        params[@"attributes"] = @"deals,hot_and_new";
    } else if (self.dealsFilter) {
        params[@"attributes"] = @"deals";
    } else if (self.hotAndNewFilter) {
        params[@"attributes"] = @"hot_and_new";
    }
    if (self.openNow && self.openAt == 0) {
        params[@"open_now"] = @(true);
    }

    return params;
}

@end
