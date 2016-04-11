//
//  YLPPhoneSearchTableViewController.h
//  YelpAPI
//
//  Created by David Chen on 3/31/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPClient;
@class YLPPhoneSearch;

@interface YLPPhoneSearchTableViewController : UITableViewController<UITableViewDelegate>
@property (nonatomic) YLPClient *client;
@property (nonatomic) YLPPhoneSearch *phoneSearch;
@end
