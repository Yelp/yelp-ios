//
//  YLPClient+ClientSetup.m
//  Pods
//
//  Created by David Chen on 4/7/16.
//
//

#import "YLPClient+ClientSetup.h"
#import "YLPClient.h"

@implementation YLPClient (ClientSetup)

+ (instancetype)newClient {
    return [[YLPClient alloc] initWithConsumerKey:@"" consumerSecret:@"" token:@"" tokenSecret:@""];
}

@end
