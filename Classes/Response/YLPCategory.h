//
//  YLPCategory.h
//  Pods
//
//  Created by David Chen on 1/11/16.
//
//

#import "YLPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPCategory : YLPBaseObject

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *alias;

@end

NS_ASSUME_NONNULL_END
