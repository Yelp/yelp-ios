//
//  YLPAutocompleteTableViewController.m
//  YelpAPI
//
//  Created by Kenny Dang on 5/6/17.
//
//

#import "YLPAutocompleteTableViewController.h"
#import "YLPAppDelegate.h"
#import <YelpAPI/YLPClient+Autocomplete.h>
#import <YelpAPI/YLPAutocomplete.h>
#import <YelpAPI/YLPCoordinate.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPCategory.h>

@interface YLPAutocompleteTableViewController ()
@property (nonatomic) YLPAutocomplete *autoCompleteResults;
@property (nonatomic, copy, readwrite) NSArray<YLPBusiness *> *myBusinesses;
@property (nonatomic, copy, readwrite) NSArray<YLPCategory *> *myCategories;
@property (nonatomic, copy, readwrite) NSArray<NSString *> *myTerms;

@end

@implementation YLPAutocompleteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    double lat = 37.7613570;
    double longi = -122.4243770;
    
    YLPCoordinate *myCoordinate = [[YLPCoordinate alloc] initWithLatitude:lat longitude:longi];
   
    
    [[YLPAppDelegate sharedClient] fetchAutocompleteSuggestionsWithTerm:@"Bakery" coordinate:myCoordinate locale:nil completionHandler:^(YLPAutocomplete * _Nullable autocomplete, NSError * _Nullable error) {
        self.autoCompleteResults = autocomplete;
        
        if (error) {
            return;
        }
        
        _myBusinesses = [NSArray arrayWithArray:self.autoCompleteResults.businesses];
        _myCategories = [self.autoCompleteResults.categories copy];
        _myTerms = [self.autoCompleteResults.terms copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.myTerms.count;
    } else if (section == 1){
        return self.myBusinesses.count;
        return 0;
    } else if (section == 2) {
        return self.myCategories.count;
    } else {
        return 0;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Terms";
    } else if (section == 1) {
        return @"Businesses";
    } else if (section == 2) {
        return @"Categories";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutocompleteCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text =  self.myTerms[indexPath.row];
    } else if (indexPath.section == 1){
        cell.textLabel.text =  self.myBusinesses[indexPath.row].name;
    } else if (indexPath.section == 2) {
        cell.textLabel.text =  self.myCategories[indexPath.row].alias;
    }
    
    return cell;
}

@end
