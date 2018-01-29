//
//  YLPAppDelegate.m
//  YelpAPI
//
//  Created by David Chen on 12/07/2015.
//  Copyright (c) 2015 David Chen. All rights reserved.
//

#import "YLPAppDelegate.h"

@import YelpAPI;

@interface YLPAppDelegate ()
@property (strong, nonatomic) YLPClient *client;
@end

@implementation YLPAppDelegate

+ (YLPClient *)sharedClient {
    YLPAppDelegate *appDelegate = (YLPAppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.client;
}

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #warning Fill in the API key below with your developer v3 key.
    self.client = [[YLPClient alloc] initWithAPIKey:@""];

    return YES;
}

@end
