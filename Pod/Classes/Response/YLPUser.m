//
//  YLPUser.m
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//

#import "YLPUser.h"

@implementation YLPUser

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier imageURLString:(NSString *)imageURLString {
    if (self = [super init]) {
        _identifier = identifier;
        _name = name;
        _imageURL = imageURLString ? [NSURL URLWithString:imageURLString] : nil;
    }
    return self;
}

@end
