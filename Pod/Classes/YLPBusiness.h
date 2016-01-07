//
//  Business.h
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import <Foundation/Foundation.h>

@interface YLPBusiness : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)businessDict;

@property (nonatomic, getter=is_claimed, readonly) BOOL isClaimed;
@property (nonatomic, getter=is_closed, readonly) BOOL isClosed;

@property (nonatomic, getter=snippet_image_url, readonly, copy) NSURL *snippetImageUrl;
@property (nonatomic, getter=rating_img_url, readonly, copy) NSURL *ratingImgUrl;
@property (nonatomic, getter=rating_img_url_small, readonly, copy) NSURL *ratingImgUrlSmall;
@property (nonatomic, getter=rating_img_url_large, readonly, copy) NSURL *ratingImgUrlLarge;
@property (nonatomic, getter=mobile_url, readonly, copy) NSURL *mobileUrl;
@property (nonatomic, getter=image_url, readonly, copy) NSURL *imageUrl;
@property (nonatomic, readonly, copy) NSURL *url;

@property (nonatomic, readonly, copy) NSNumber *rating;
@property (nonatomic, getter=review_count, readonly, copy) NSNumber *reviewCount;
@property (nonatomic, getter=menu_date_updated, readonly, copy) NSNumber *menuDateUpdated;

@property (nonatomic, getter=snippet_text, readonly, copy) NSString *snippetText;
@property (nonatomic, getter=menu_provider, readonly, copy) NSString *menuProvider;
@property (nonatomic, getter=display_phone, readonly, copy) NSString *displayPhone;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *phone;
@property (nonatomic, readonly, copy) NSString *id;

//TODO: Convert these to actual objects
@property (nonatomic, readonly, copy) NSMutableArray *categories;
@property (nonatomic, readonly, copy) NSMutableArray *reviews;
@property (nonatomic, readonly, copy) NSMutableArray *location;

@end
