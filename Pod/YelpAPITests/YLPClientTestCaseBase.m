//
//  YLPClientTestCaseBase.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "YLPClientTestCaseBase.h"

@implementation YLPClientTestCaseBase

- (void)setUp {
    [super setUp];
    self.client = [[YLPClient alloc] initWithConsumerKey:@"consumerKey" consumerSecret:@"consumerSecret" token:@"token" tokenSecret:@"tokenSecret"];
    self.bogusTestPath = @"/bogusPath";
}

- (void)tearDown {
    [super tearDown];
    [OHHTTPStubs removeAllStubs];
}

@end
