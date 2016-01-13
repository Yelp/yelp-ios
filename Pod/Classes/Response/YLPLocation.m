//
//  YLPLocation.m
//  Pods
//
//  Created by David Chen on 1/12/16.
//
//

#import "YLPLocation.h"
#import "YLPCoordinate.h"
#import "YLPResponsePrivate.h"

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
        
        if (location[@"coordinate"]) {
            double lat = [location[@"coordinate"][@"latitude"] doubleValue];
            double longitude = [location[@"coordinate"][@"longitude"] doubleValue];
            if (lat && longitude) {
                _coordinate = [[YLPCoordinate alloc] initWithLatitude:lat longitude:longitude];
            }
        }
    }
    
    return self;
}

@end
