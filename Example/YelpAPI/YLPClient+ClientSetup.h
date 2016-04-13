//
//  YLPClient+ClientSetup.h
//  YelpAPI
//
//  Created by David Chen on 4/7/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YelpAPI/YLPClient.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPClient (ClientSetup)

+ (instancetype)newClient;

@end

NS_ASSUME_NONNULL_END