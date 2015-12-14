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
#import <pop/POP.h>
#import "PJModalView.h"
#import "AddNewNetworkViewController.h"
#import "OCRController.h"

@interface NetworkSelectionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *rememberNetwork;
- (IBAction)rememberNetworkAction:(id)sender;

@property (nonatomic) NSMutableArray *listOfNetwork;

@end
