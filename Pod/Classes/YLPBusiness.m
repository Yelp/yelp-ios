//
//  Business.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import "YLPBusiness.h"
@interface YLPBusiness (){
}
@property (nonatomic, readonly) BOOL is_claimed;
@property (nonatomic, readonly) BOOL is_closed;

@property (nonatomic, readonly, copy) NSURL *snippet_image_url;
@property (nonatomic, readonly, copy) NSURL *rating_img_url;
@property (nonatomic, readonly, copy) NSURL *rating_img_url_small;
@property (nonatomic, readonly, copy) NSURL *rating_img_url_large;
@property (nonatomic, readonly, copy) NSURL *mobile_url;
@property (nonatomic, readonly, copy) NSURL *image_url;

@property (nonatomic, readonly, copy) NSNumber *review_count;
@property (nonatomic, readonly, copy) NSNumber *menu_date_updated;

@property (nonatomic, readonly, copy) NSString *snippet_text;
@property (nonatomic, readonly, copy) NSString *menu_provider;
@property (nonatomic, readonly, copy) NSString *display_phone;
@end

@implementation YLPBusiness
- (instancetype)initWithDictionary:(NSDictionary *)businessDict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:businessDict];
    }
    
    return self;
}
@end
