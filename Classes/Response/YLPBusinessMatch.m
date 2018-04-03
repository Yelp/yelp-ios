//
//  YLPBusinessMatch.m
//  YelpAPI
//
//  Created by Kevin Farst on 4/4/18.
//

#import "YLPBusinessMatch.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusinessMatch

- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        _name = businessDict[@"name"];
        _identifier = businessDict[@"id"];
        
        NSString *phone = [businessDict ylp_objectMaybeNullForKey:@"phone"];
        _phone = phone.length > 0 ? phone : nil;
        
        NSString *displayPhone = [businessDict ylp_objectMaybeNullForKey:@"display_phone"];
        _displayPhone = displayPhone.length > 0 ? displayPhone : nil;
        
        NSArray<NSString *> *displayAddress = [businessDict ylp_arrayMaybeNullForKey:@"display_address"];
        _displayAddress = displayAddress;
        
        YLPCoordinate *coordinate = [self.class coordinateFromJSONDictionary:businessDict[@"coordinates"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"] coordinate:coordinate];
    }
    return self;
}

+ (NSArray *)businessMatchesFromJSONArray:(NSArray *)businessMatchesJSON {
    NSMutableArray<YLPBusinessMatch *> *businessMatches = [[NSMutableArray alloc] init];
    for (NSDictionary *business in businessMatchesJSON) {
        [businessMatches addObject:[[YLPBusinessMatch alloc] initWithDictionary:business]];
    }
    return businessMatches;
}

+ (YLPCoordinate *)coordinateFromJSONDictionary:(NSDictionary *)coordinatesDict {
    NSNumber *latitude = [coordinatesDict ylp_objectMaybeNullForKey:@"latitude"];
    NSNumber *longitude = [coordinatesDict ylp_objectMaybeNullForKey:@"longitude"];
    if (latitude && longitude) {
        return [[YLPCoordinate alloc] initWithLatitude:[latitude doubleValue]
                                             longitude:[longitude doubleValue]];
    } else {
        return nil;
    }
}

@end

