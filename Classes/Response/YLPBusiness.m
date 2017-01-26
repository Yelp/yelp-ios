//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
#import "YLPCategory.h"
//#import "YLPBusinessHours.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusiness

- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        _closed = [businessDict[@"is_closed"] boolValue];

        _URL = [[NSURL alloc] initWithString:businessDict[@"url"]];
        NSString *imageURLString = [businessDict ylp_objectMaybeNullForKey:@"image_url"];
        _imageURL = imageURLString.length > 0 ? [[NSURL alloc] initWithString:imageURLString] : nil;
        
        _rating = [businessDict[@"rating"] doubleValue];
        _reviewCount = [businessDict[@"review_count"] integerValue];
        
        _name = businessDict[@"name"];
        _identifier = businessDict[@"id"];
        NSString *phone = [businessDict ylp_objectMaybeNullForKey:@"phone"];
        _phone = phone.length > 0 ? phone : nil;
        
        NSArray *photos = [businessDict ylp_objectMaybeNullForKey:@"photos"];
        _photos = photos.count > 0 ? photos : nil;
        
        NSArray *hours = [businessDict ylp_objectMaybeNullForKey:@"hours"];
        _hours = hours.count > 0 ? [self.class hoursFromJSONArray:businessDict[@"hours"]] : nil;
        
        _categories = [self.class categoriesFromJSONArray:businessDict[@"categories"]];
        YLPCoordinate *coordinate = [self.class coordinateFromJSONDictionary:businessDict[@"coordinates"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"] coordinate:coordinate];
    }
    return self;
}

+ (NSArray *)hoursFromJSONArray:(NSArray *)hoursJSON {
    NSMutableArray *mutableHours = [[NSMutableArray alloc] init];
    for (NSDictionary *hour in hoursJSON) {
        [mutableHours addObject:[[YLPBusinessHours alloc] initWithDictionary:hour]];
        [mutableHours addObject:hour];
    }
    return mutableHours;
}

+ (NSArray *)categoriesFromJSONArray:(NSArray *)categoriesJSON {
    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
    for (NSDictionary *category in categoriesJSON) {
        [mutableCategories addObject:[[YLPCategory alloc] initWithDictionary:category]];
    }
    return mutableCategories;
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
