//
//  YLPTableViewController.h
//  YelpAPI
//
//  Created by David Chen on 3/30/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLPClient;
@class YLPBusiness;

@interface YLPBusinessViewController : UITableViewController <UITableViewDelegate>
@property (nonatomic) YLPClient *client;
@property (nonatomic) YLPBusiness *business;
@end
