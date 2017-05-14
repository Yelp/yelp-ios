//
//  YLPAutocomplete.m
//  YelpAPI
//
//  Created by Kenny Dang on 5/5/17.
//
//

#import "YLPAutocomplete.h"
#import "YLPResponsePrivate.h"

@implementation YLPAutocomplete

- (instancetype)initWithDictionary:(NSDictionary *)autocompleteDict {
    if (self = [super init]) {
        _businesses = [self.class businessesFromJSONArray:autocompleteDict[@"businesses"]];
        _categories = [self.class categoriesFromJSONArray:autocompleteDict[@"categories"]];
        _terms = [self.class termsFromJSONArray:autocompleteDict[@"terms"]];
    }

    return self;
}

+ (NSArray *)businessesFromJSONArray:(NSArray *)businessesJSON {
    NSMutableArray<YLPBusiness *> *mutableBusinessesJSON = [[NSMutableArray alloc] init];
    
    for (NSDictionary *business in businessesJSON) {
        [mutableBusinessesJSON addObject:[[YLPBusiness alloc] initWithAutocompleteDictionary:business]];
    }
    
    return mutableBusinessesJSON;
}

+ (NSArray *)categoriesFromJSONArray:(NSArray *)categoriesJSON {
    NSMutableArray<YLPCategory *> *mutableCategoriesJSON = [[NSMutableArray alloc] init];
    
    for (NSDictionary *category in categoriesJSON) {
        [mutableCategoriesJSON addObject:[[YLPCategory alloc] initWithDictionary:category]];
    }
    
    return mutableCategoriesJSON;
}

+ (NSArray *)termsFromJSONArray:(NSArray *)termsJSON {
    NSMutableArray<NSString *> *mutableTermsJSON = [[NSMutableArray alloc] init];
    
    for (NSDictionary *term in termsJSON) {
        [mutableTermsJSON addObject: term[@"text"]];
    }
    
    return mutableTermsJSON;
}

@end
