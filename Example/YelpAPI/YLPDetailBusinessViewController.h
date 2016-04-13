//
//  YLPDetailBusinessViewController.h
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPBusiness;

@interface YLPDetailBusinessViewController : UIViewController

@property (nonatomic) YLPBusiness *business;
@property (nonatomic) IBOutlet UILabel *businessName;
@property (nonatomic) IBOutlet UILabel *businessAddress;
@property (nonatomic) IBOutlet UILabel *businessPhone;
@end
