//
//  YLPQueryPrivate.h
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import "YLPQuery.h"

typedef NS_ENUM(NSUInteger, YLPSearchMode) {
    YLPSearchModeLocation,
    YLPSearchModeBounds,
    YLPSearchModeCoordinate,
};

NS_ASSUME_NONNULL_BEGIN

@interface YLPQuery ()

@property (assign, nonatomic) YLPSearchMode mode;
@property (copy, nonatomic, nullable) NSString *location;
@property (strong, nonatomic, nullable) YLPCoordinate *currentLatLong;
@property (strong, nonatomic, nullable) YLPGeoBoundingBox *bounds;
@property (strong, nonatomic, nullable) YLPGeoCoordinate *geoCoordinate;

- (NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
