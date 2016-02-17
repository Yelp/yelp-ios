//
//  YLPReview.m
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPReview.h"
#import "YLPUser.h"
#import "YLPResponsePrivate.h"

@implementation YLPReview

- (instancetype)initWithDictionary:(NSDictionary *)reviewDict {
    if (self = [super init]) {
        _rating = [reviewDict[@"rating"] doubleValue];
        _excerpt = reviewDict[@"excerpt"];
        _timeCreated = [NSDate dateWithTimeIntervalSince1970:[reviewDict[@"time_created"] doubleValue]];
        _ratingImageURL = [NSURL URLWithString:reviewDict[@"rating_image_url"]];
        _ratingImageSmallURL = [NSURL URLWithString:reviewDict[@"rating_image_small_url"]];
        _ratingImageLargeURL = [NSURL URLWithString:reviewDict[@"rating_image_large_url"]];
        
        _user = [[YLPUser alloc] initWithName:reviewDict[@"user"][@"name"] identifier:reviewDict[@"user"][@"id"] imageURLString:reviewDict[@"user"][@"image_url"]];
        
    }
    
    return self;
}

@end
