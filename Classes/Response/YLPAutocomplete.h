//
//  YLPAutocomplete.h
//  YelpAPI
//
//  Created by Kenny Dang on 5/5/17.
//
//

#import <Foundation/Foundation.h>

@class YLPSearch;
@class YLPCategory;
@class YLPBusiness;

NS_ASSUME_NONNULL_BEGIN

@interface YLPAutocomplete : NSObject

@property (nonatomic, readonly) NSArray<YLPBusiness *> *businesses;
@property (nonatomic, readonly) NSArray<YLPCategory *> *categories;
@property (nonatomic, readonly) NSArray<NSString *> *terms;

@end

NS_ASSUME_NONNULL_END
