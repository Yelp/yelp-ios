//
//  YLPBusinessMatch.h
//  YelpAPI
//
//  Created by Kevin Farst on 4/4/18.
//

#import <Foundation/Foundation.h>

@class YLPLocation;

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusinessMatch : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, nullable, copy) NSString *phone;
@property (nonatomic, readonly, nullable, copy) NSString *displayPhone;
@property (nonatomic, readonly, copy) NSString *identifier;
@property (nonatomic, readonly, copy) NSArray<NSString *> *displayAddress;

@property (nonatomic, readonly) YLPLocation *location;

@end

NS_ASSUME_NONNULL_END

