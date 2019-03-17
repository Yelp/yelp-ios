//
//  YLPQuery.h
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import <Foundation/Foundation.h>
#import "YLPSortType.h"

@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN

@interface YLPQuery : NSObject

/**
 Initializes a query with a location specified by text.
 @param location the particular neighborhood, address or city to search in
 */
- (instancetype)initWithLocation:(NSString *)location;

/**
 Initializes a query with a location specified by a coordinate.
 @param coordinate coordinate around which to search
 */
- (instancetype)initWithCoordinate:(YLPCoordinate *)coordinate;

/**
 Search term (e.g. "food", "restaurants"). If term is nil, everything will be searched.
 */
@property (copy, nonatomic, nullable) NSString *term;

/**
 Search price ("1", "2", "3", or "4"). If term is nil, everything will be searched.
 */
@property (copy, nonatomic, nullable) NSString *price;

/**
 Search locale, language to return the business information in.
 */
@property (copy, nonatomic, nullable) NSString *locale;

/**
 Number of business results to return. If 0, the API maximum of 20 results will be returned.
 */
@property (assign, nonatomic) NSUInteger limit;

/**
 An integer represending the Unix time in the same timezone of the search location. If specified, it will return business open at the given time.
 */
@property (assign, nonatomic) NSUInteger openAt;

/**
 Whether to exclusively search for businesses open now. If openAt has value > 0 then only openAt is used.
 */
@property (assign, nonatomic) BOOL openNow;

/**
 Amount by which to offset the list of returned business. The default is 0.
 */
@property (assign, nonatomic) NSUInteger offset;

/**
 Sort mode for the list of returned businesses. The default is BestMatched.
 */
@property (assign, nonatomic) YLPSortType sort;

/**
 Aliases of categories to filter search results with. If none, all results will be returned.
 */
@property (copy, nonatomic, null_resettable) NSArray<NSString *> *categoryFilter;

/**
 Search radius in meters. If the value is too large, an AREA_TOO_LARGE error may be returned.
 */
@property (assign, nonatomic) double radiusFilter;

/**
 Whether to exclusively search for businesses with deals.
 */
@property (assign, nonatomic) BOOL dealsFilter;

/**
 Whether to exclusively search for businesses that are hot and new.
 */
@property (assign, nonatomic) BOOL hotAndNewFilter;

@end

NS_ASSUME_NONNULL_END
