//
//  YLPClient+Autocomplete.m
//  YelpAPI
//
//  Created by Kenny Dang on 5/5/17.
//
//

#import "YLPClient+Autocomplete.h"
#import "YLPQuery.h"
#import "YLPCoordinate.h"
#import "YLPQueryPrivate.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Autocomplete)

- (NSURLRequest *)autoCompleteRequestWithParams:(NSDictionary *)params {
    NSString *autoCompletePath = @"/v3/autocomplete";
    
    return [self requestWithPath:autoCompletePath params:params];
}

- (void)fetchAutocompleteSuggestionsWithTerm:(NSString *)term
                                  coordinate:(YLPCoordinate *)coordinate
                                      locale:(NSString *)locale
                           completionHandler:(YLPAutocompleteCompletionHandler)completionHandler {
    
    NSMutableDictionary *mutableParams = [[NSMutableDictionary alloc] init];
    
    if (coordinate) {
        YLPQuery *query = [[YLPQuery alloc] initWithCoordinate: coordinate];
        NSDictionary *params = [query parameters];
        mutableParams = [params mutableCopy];
    }
    
    mutableParams[@"text"] = term;
    
    if (locale) {
        mutableParams[@"locale"] = locale;
    }

    NSURLRequest *request = [self autoCompleteRequestWithParams:mutableParams];
    
    [self queryWithRequest:request completionHandler:^(NSDictionary * _Nonnull responseDict, NSError * _Nonnull error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPAutocomplete *autoCompleteSuggestions = [[YLPAutocomplete alloc] initWithDictionary:responseDict];
            completionHandler(autoCompleteSuggestions, nil);
        }
    }];
}

@end
