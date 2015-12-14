//
//  NetworkSelectionViewController.h
//  EasyTopup
//
//  Created by Eeposit1 on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"
#import "NetworkCell.h"

@interface NetworkSelectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *rememberNetwork;
@property (nonatomic) NSMutableArray *listOfNetwork;

@end
