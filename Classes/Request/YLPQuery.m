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
#import "YLPGeoBoundingBox.h"
#import "YLPGeoCoordinate.h"

@implementation YLPQuery

- (instancetype)initWithLocation:(NSString *)location currentLatLong:(nullable YLPCoordinate *)cll {
    if (self = [super init]) {
        _mode = YLPSearchModeLocation;
        _location = [location copy];
        _currentLatLong = cll;
    }
    return self;
}

- (instancetype)initWithBounds:(YLPGeoBoundingBox *)bounds {
    if (self = [super init]) {
        _mode = YLPSearchModeBounds;
        _bounds = bounds;
    }
    return self;
}

- (instancetype)initWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate {
    if (self = [super init]) {
        _mode = YLPSearchModeCoordinate;
        _geoCoordinate = geoCoordinate;
    }
    return self;
}

- (NSArray<NSString *> *)categoryFilter {
    return _categoryFilter ?: @[];
}

- (NSDictionary *)parameters {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    switch (self.mode) {
        case YLPSearchModeLocation:
            params[@"location"] = self.location;
            break;
        case YLPSearchModeBounds:
            params[@"bounds"] = self.bounds.description;
            break;
        case YLPSearchModeCoordinate:
            params[@"ll"] = self.geoCoordinate.description;
            break;
    }

    if (self.currentLatLong) {
        params[@"cll"] = self.currentLatLong.description;
    }
    if (self.term) {
        params[@"term"] = self.term;
    }
    if (self.limit) {
        params[@"limit"] = @(self.limit);
    }
    if (self.offset) {
        params[@"offset"] = @(self.offset);
    }
    if (self.sort) {
        params[@"sort"] = @(self.sort);
    }
    if (self.categoryFilter.count > 0) {
        params[@"category_filter"] = [self.categoryFilter componentsJoinedByString:@","];
    }
    if (self.radiusFilter > 0) {
        params[@"radius_filter"] = @(self.radiusFilter);
    }
    if (self.dealsFilter) {
        params[@"deals_filter"] = @(YES);
    }

    return params;
}

@end
