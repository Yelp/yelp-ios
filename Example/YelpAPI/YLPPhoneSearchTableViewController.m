//
//  YLPPhoneSearchTableViewController.m
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPPhoneSearchTableViewController.h"
#import "YLPDetailBusinessViewController.h"
#import "YLPClient+ClientSetup.h"
#import <YelpAPI/YLPClient+PhoneSearch.h>
#import <YelpAPI/YLPPhoneSearch.h>
#import <YelpAPI/YLPBusiness.h>

@interface YLPPhoneSearchTableViewController ()

@end

@implementation YLPPhoneSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [YLPClient newClient];
    dispatch_group_t requestGroup = dispatch_group_create();
    dispatch_group_enter(requestGroup);
    
    // Invalid response
    [self.client businessWithPhoneNumber:@"+++4158759656" completionHandler:^
        (YLPPhoneSearch *phoneSearch, NSError* error) {
            NSString *cellDescription;
            if (error) {
                cellDescription = error.userInfo[@"error"][@"text"];
            }
            else {
                self.phoneSearch = phoneSearch;
                cellDescription = self.phoneSearch.businesses[0].name;
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                cell.textLabel.text = cellDescription;
                [self.tableView reloadData];
            });
            dispatch_group_leave(requestGroup);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
