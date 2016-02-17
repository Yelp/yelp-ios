//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
#import "YLPCategory.h"
#import "YLPGiftCertificate.h"
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
        _categories = [self.class categoriesFromJSONArray:businessDict[@"categories"]];
        _reviews = [self.class reviewsFromJSONArray:businessDict[@"reviews"]];
        _giftCertificates = [self.class giftCertificatesFromJSONArray:businessDict[@"gift_certificates"]];
        _deals = [self.class dealsFromJSONArray:businessDict[@"deals"]];
        _location = [[YLPLocation alloc] initWithDictionary:businessDict[@"location"]];
    }
    return self;
}

+ (NSArray *)categoriesFromJSONArray:(NSArray *)categoriesJSON {
    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
    for (NSArray *category in categoriesJSON) {
        [mutableCategories addObject:[[YLPCategory alloc] initWithName:category[0] alias:category[1]]];
    }
    return mutableCategories;
}

+ (NSArray *)reviewsFromJSONArray:(NSArray *)reviewsJSON {
    NSMutableArray *mutableReviews = [[NSMutableArray alloc] init];
    
    for (NSDictionary *review in reviewsJSON) {
        [mutableReviews addObject:[[YLPReview alloc] initWithDictionary:review]];
    }
    
    return mutableReviews;
}

+ (NSArray *)giftCertificatesFromJSONArray:(NSArray *)giftCertificatesJSON {
    NSMutableArray *mutableGiftCertificates = [[NSMutableArray alloc] init];
    
    for (NSDictionary *gc in giftCertificatesJSON) {
        [mutableGiftCertificates addObject:[[YLPGiftCertificate alloc] initWithDictionary:gc]];
    }
    
    return mutableGiftCertificates;
}

+ (NSArray *)dealsFromJSONArray:(NSArray *)dealsJSON {
    NSMutableArray *mutableDeals = [[NSMutableArray alloc] init];
    
    for (NSDictionary *deal in dealsJSON) {
        [mutableDeals addObject:[[YLPDeal alloc] initWithDictionary:deal]];
    }
    return mutableDeals;
}

@end
