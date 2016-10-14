//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPCoordinate.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusiness

- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        _URL = [[NSURL alloc] initWithString:businessDict[@"url"]];
        _imageURL = businessDict[@"image_url"] ? [[NSURL alloc] initWithString:businessDict[@"image_url"]] : nil;
        
        _rating = [businessDict[@"rating"] doubleValue];
        _reviewCount = [businessDict[@"review_count"] integerValue];
        
        _name = businessDict[@"name"];
        _phone = businessDict[@"phone"];
        _identifier = businessDict[@"id"];
        
        _categories = [self.class categoriesFromJSONArray:businessDict[@"categories"]];
        YLPCoordinate *coordinate = [self.class coordinateFromJSONDictionary:businessDict[@"coordinates"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"] coordinate:coordinate];
    }
    return self;
}

+ (NSArray *)categoriesFromJSONArray:(NSArray *)categoriesJSON {
    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
    for (NSDictionary *category in categoriesJSON) {
        [mutableCategories addObject:[[YLPCategory alloc] initWithDictionary:category]];
    }
    return mutableCategories;
}

+ (YLPCoordinate *)coordinateFromJSONDictionary:(NSDictionary *)coordinatesDict {
    NSNumber *latitude = coordinatesDict[@"latitude"];
    NSNumber *longitude = coordinatesDict[@"longitude"];
    if (latitude && longitude) {
        return [[YLPCoordinate alloc] initWithLatitude:[latitude doubleValue]
                                             longitude:[longitude doubleValue]];
    } else {
        return nil;
    }
}

@end
