//
//  YLPClientTestCaseHeader.m
//  Pods
//
//  Created by David Chen on 1/5/16.
//
//
#import <XCTest/XCTest.h>
#import <YelpAPI/YLPClient.h>

@interface YLPClientTestCaseBase : XCTestCase

@property (nonatomic) YLPClient *client;
@property (nonatomic, copy) NSString *bogusTestPath;
@property (nonatomic, copy) NSString *defaultResource;

- (NSDictionary *)loadExpectedResponse:(NSString *)resource;

@end

@interface YLPClient (Testing)

- (NSURLRequest *)requestWithPath:(NSString *)path;
- (NSURLRequest *)requestWithPath:(NSString *)path params:(NSDictionary *)params;

- (void)queryWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSDictionary *jsonResponse, NSError *error))completionHandler;

@end