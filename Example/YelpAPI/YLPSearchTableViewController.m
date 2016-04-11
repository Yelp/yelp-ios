//
//  YLPSearchTableViewController.m
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPSearchTableViewController.h"
#import "YLPDetailBusinessViewController.h"
#import "YLPClient+ClientSetup.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPBusiness.h>

@interface YLPSearchTableViewController ()

@end

@implementation YLPSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [YLPClient newClient];
    
    [self.client searchWithLocation:@"San Francisco, CA" currentLatLong:nil term:nil limit:5 offset:0 sort:0 completionHandler:^
        (YLPSearch *search, NSError* error) {
            self.search = search;
            dispatch_sync(dispatch_get_main_queue(), ^{
                for (int i = 0; i < [self.search.businesses count]; i++) {
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.textLabel.text = self.search.businesses[i].name;
                    
                }
                [self.tableView reloadData];
            });
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YLPDetailBusinessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YLPDetailBusinessViewController"];
    vc.business = self.search.businesses[indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
