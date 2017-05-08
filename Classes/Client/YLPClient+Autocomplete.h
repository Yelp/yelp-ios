//
//  YLPClient+Autocomplete.h
//  YelpAPI
//
//  Created by Kenny Dang on 5/5/17.
//
//

#import "YLPClient.h"

@class YLPAutocomplete;
@class YLPQuery;
@class YLPCoordinate;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPAutocompleteCompletionHandler)(YLPAutocomplete *_Nullable autocomplete, NSError *_Nullable error);

@interface YLPClient (Autocomplete)

- (void)fetchAutocompleteSuggestionsWithTerm:(NSString *)term
                                  coordinate:(YLPCoordinate *)coordinate
                                      locale:(nullable NSString *)locale
                           completionHandler:(YLPAutocompleteCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
