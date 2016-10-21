//
//  YLPPhoneSearchTableViewController.m
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPPhoneSearchTableViewController.h"
#import "YLPDetailBusinessViewController.h"
#import "YLPAppDelegate.h"
#import <YelpAPI/YLPClient+PhoneSearch.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPSearch.h>

@interface YLPPhoneSearchTableViewController ()
@property (nonatomic) YLPSearch *phoneSearch;
@property (nonatomic) NSError *error;
@end

@implementation YLPPhoneSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Purposefully issue an invalid request.
    [[YLPAppDelegate sharedClient] businessWithPhoneNumber:@"+++4158759656" completionHandler:^
        (YLPSearch *phoneSearch, NSError *error) {
            self.error = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneSearchCell" forIndexPath:indexPath];
    cell.textLabel.text = self.error.userInfo[@"error"][@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YLPDetailBusinessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YLPDetailBusinessViewController"];
    if (self.phoneSearch) {
        vc.business = self.phoneSearch.businesses[indexPath.item];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
