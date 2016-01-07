//
//  YLPClient+Business.h
//  Pods
//
//  Created by David Chen on 1/4/16.
//
//

#import <Foundation/Foundation.h>
#import "YLPClient.h"
#import "YLPBusiness.h"

@interface YLPClient (Business)
- (void)getBusinessWithId:(NSString *)businessId completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;
- (void)getBusinessWithId:(NSString *)businessId countryCode:(NSString *)countryCode languageCode:(NSString *)languageCode languageFilter:(bool)languageFilter actionLinks:(bool)actionLinks completionHandler:(void (^)(YLPBusiness *business, NSError *error))completionHandler;
@end
