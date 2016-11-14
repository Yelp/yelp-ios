//
//  YLPUser.m
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPUser.h"

@implementation YLPUser

- (instancetype)initWithDictionary:(NSDictionary *)userDict {
    if (self = [super init]) {
        _name = userDict[@"name"];
        id imageURL = userDict[@"image_url"];
        if (imageURL && ![imageURL isEqual:[NSNull null]]) {
            _imageURL = [NSURL URLWithString:imageURL];
        } else {
            _imageURL = nil;
        }
    }
    return self;
}

@end
