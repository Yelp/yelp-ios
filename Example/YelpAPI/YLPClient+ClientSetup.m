//
//  YLPClient+ClientSetup.m
//  YelpAPI
//
//  Created by David Chen on 4/7/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPClient+ClientSetup.h"
#import <YelpAPI/YLPClient.h>

@implementation YLPClient (ClientSetup)

+ (instancetype)newClient {
    return [[YLPClient alloc] initWithConsumerKey:@"" consumerSecret:@"" token:@"" tokenSecret:@""];
}

@end
