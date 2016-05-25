//
//  YLPLocation.m
//  Pods
//
//  Created by David Chen on 1/12/16.
//
//

#import "YLPLocation.h"
#import "YLPCoordinate.h"

@implementation YLPLocation

- (instancetype)initWithDictionary:(NSDictionary *)location {
    if (self = [super init]) {
        _city = location[@"city"];
        _stateCode = location[@"state_code"];
        _postalCode = location[@"postal_code"];
        _countryCode = location[@"country_code"];
        _crossStreets = location[@"cross_streets"];
        
        _displayAddress = location[@"display_address"];
        _neighborhoods = location[@"neighborhoods"];
        _address = location[@"address"];
        
        _geoAccuracy = [location[@"geo_accuracy"] doubleValue];
        NSNumber *latitude = location[@"coordinate"][@"latitude"];
        NSNumber *longitude = location[@"coordinate"][@"longitude"];
        if (latitude && longitude) {
            _coordinate = [[YLPCoordinate alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
        }
    }
    
    return self;
}

@end
