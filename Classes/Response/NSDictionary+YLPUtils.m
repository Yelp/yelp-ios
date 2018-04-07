//
//  NSDictionary+YLPUtils.m
//  YelpAPI
//
//  Created by Steven Sheldon on 11/17/16.
//
//

#import "YLPResponsePrivate.h"

@implementation NSDictionary (YLPUtils)

- (id)ylp_objectMaybeNullForKey:(id)key {
    id obj = self[key];
    if ([obj isEqual:[NSNull null]]) {
        return nil;
    }
    return obj;
}

- (id)ylp_arrayMaybeNullForKey:(id)key {
    id obj = self[key];
    NSMutableArray *valueArrayFromKey = [NSMutableArray new];
    
    if ([obj isEqual:[NSNull null]]) {
        return valueArrayFromKey;
    }
    
    for (id arrayObj in obj) {
        [valueArrayFromKey arrayByAddingObject:arrayObj];
    }
    
    return obj;
}

@end
