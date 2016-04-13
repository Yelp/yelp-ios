//
//  YLPBusinessViewController.m
//  YelpAPI
//
//  Created by David Chen on 3/30/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPBusinessViewController.h"
#import "YLPDetailBusinessViewController.h"
#import "YLPClient+ClientSetup.h"
#import <YelpAPI/YLPClient+Business.h>
#import <YelpAPI/YLPBusiness.h>

@interface YLPBusinessViewController ()
@property (nonatomic) YLPClient *client;
@property (nonatomic) YLPBusiness *business;

@end

@implementation YLPBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [YLPClient newClient];
    
    [self.client businessWithId:@"gary-danko-san-francisco" completionHandler:^
        (YLPBusiness *business, NSError* error) {
            self.business = business;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LabelCell" forIndexPath:indexPath];
    cell.textLabel.text = self.business.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YLPDetailBusinessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"YLPDetailBusinessViewController"];
    vc.business = self.business;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
