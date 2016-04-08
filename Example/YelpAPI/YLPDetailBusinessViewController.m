//
//  YLPDetailBusinessViewController.m
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import "YLPDetailBusinessViewController.h"
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPLocation.h>

@interface YLPDetailBusinessViewController ()

@end

@implementation YLPDetailBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.businessName.text = self.business.name;
    self.businessPhone.text = self.business.displayPhone;
    self.businessAddress.text = self.business.location.displayAddress[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
