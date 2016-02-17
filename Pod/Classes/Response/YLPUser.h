//
//  YLPUser.h
//  Pods
//
//  Created by David Chen on 1/13/16.
//
//
NS_ASSUME_NONNULL_BEGIN

@interface YLPUser : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, nullable, readonly) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END