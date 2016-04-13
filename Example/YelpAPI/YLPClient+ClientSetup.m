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
    return [[YLPClient alloc] initWithConsumerKey:@"iVCuYETQ-P8VeICYOQS7pA" consumerSecret:@"N3GHCATpE2rQ2N9kYFw6WGDgwZA" token:@"i-T6I4uq2oh3N9JodpnP-VJ58kTXAMtw" tokenSecret:@"SYA4ajJFU-RniwW3Q4k38d9G9WY"];
}

@end
