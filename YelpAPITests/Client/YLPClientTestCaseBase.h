//
//  YLPClientTestCaseHeader.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//
#import <XCTest/XCTest.h>

@class YLPClient;

@interface YLPClientTestCaseBase : XCTestCase

@property (nonatomic) YLPClient *client;
@property (nonatomic, copy) NSString *bogusTestPath;
@property (nonatomic, copy) NSString *defaultResource;

- (NSDictionary *)loadExpectedResponse:(NSString *)resource;

@end
