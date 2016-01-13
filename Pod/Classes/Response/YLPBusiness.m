//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPLocation.h"
#import "YLPResponsePrivate.h"

@implementation YLPBusiness

- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        _claimed = [businessDict[@"is_claimed"] boolValue];
        _closed = [businessDict[@"is_closed"] boolValue];
        
        _ratingImgURL = [[NSURL alloc] initWithString:businessDict[@"rating_img_url"]];
        _ratingImgURLSmall = [[NSURL alloc] initWithString:businessDict[@"rating_img_url_small"]];
        _ratingImgURLLarge = [[NSURL alloc] initWithString:businessDict[@"rating_img_url_large"]];
        _mobileURL = [[NSURL alloc] initWithString:businessDict[@"mobile_url"]];
        _URL = [[NSURL alloc] initWithString:businessDict[@"url"]];
        
        _snippetImageURL = businessDict[@"snippet_image_url"] ? [[NSURL alloc] initWithString:businessDict[@"snippet_image_url"]] : nil;
        _imageURL = businessDict[@"image_url"] ? [[NSURL alloc] initWithString:businessDict[@"image_url"]] : nil;
        _reservationURL = businessDict[@"reservation_url"] ? [[NSURL alloc] initWithString:businessDict[@"reservation_url"]] : nil;
        _eat24URL = businessDict[@"eat24_url"] ? [[NSURL alloc] initWithString:businessDict[@"eat24_url"]] : nil;
        
        _rating = [businessDict[@"rating"] doubleValue];
       
        _reviewCount = [businessDict[@"review_count"] integerValue];
        
        _snippetText = businessDict[@"snippet_text"];
        _menuProvider = businessDict[@"menu_provider"];
        _displayPhone = businessDict[@"display_phone"];
        _name = businessDict[@"name"];
        _phone = businessDict[@"phone"];
        _identifier = businessDict[@"id"];
        
        _menuDateUpdated = [NSDate dateWithTimeIntervalSince1970:[businessDict[@"menu_date_updated"] doubleValue]];
        
        [self setCategories:businessDict[@"categories"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"]];
        _reviews = businessDict[@"reviews"];
        _giftCertificates = businessDict[@"gift_certificates"];
        _deals = businessDict[@"deals"];
    }
    return self;
}

- (void)setCategories:(NSArray *)categories {
    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
    for (id category in categories) {
        [mutableCategories addObject:[[YLPCategory alloc] initWithName:category[0] alias:category[1]]];
    }
    _categories = [[NSArray alloc] initWithArray:mutableCategories];
}


@end
