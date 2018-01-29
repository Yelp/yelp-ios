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
#import "YLPClientPrivate.h"

@implementation YLPClientTestCaseBase

- (void)setUp {
    [super setUp];
    self.client = [[YLPClient alloc] initWithAPIKey:@"API_KEY"];
    self.bogusTestPath = @"/bogusPath";
}

- (void)tearDown {
    [super tearDown];
    [OHHTTPStubs removeAllStubs];
}

- (NSDictionary *)loadExpectedResponse:(NSString *)resource {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *filePath = [bundle pathForResource:resource ofType:@""];
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:nil];
}
@end
