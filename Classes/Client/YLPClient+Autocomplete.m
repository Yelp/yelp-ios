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
    NSString *phoneSearchPath = @"/v3/autocomplete";
    
    return [self requestWithPath:phoneSearchPath params:params];
}

- (void)fetchAutocompleteSuggestionsWithTerm:(NSString *)term
                                  coordinate:(YLPCoordinate *)coordinate
                                      locale:(NSString *)locale
                           completionHandler:(YLPAutocompleteCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithCoordinate: coordinate];
    
    NSDictionary *params = [query parameters];

    NSMutableDictionary *mutablesParams = [params mutableCopy];
    mutablesParams[@"text"] = term;
    
    if (locale) {
        mutablesParams[@"locale"] = locale;
    }

    NSURLRequest *request = [self autoCompleteRequestWithParams:mutablesParams];
    
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
