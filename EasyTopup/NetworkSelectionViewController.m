//
//  NetworkSelectionViewController.m
//  EasyTopup
//
//  Created by Eeposit1 on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import "NetworkSelectionViewController.h"

@implementation NetworkSelectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _rememberNetwork.transform = CGAffineTransformMakeScale(0.75, 0.75);
    _listOfNetwork = [NSMutableArray new];
    
    Network *ntcPostPaid = [Network new];
    ntcPostPaid.name = @"NTC Post Paid";
    ntcPostPaid.prefix = @"*411*";
    ntcPostPaid.suffix = @"*10#";
    ntcPostPaid.networkID = @"ntcpostpaid";
    ntcPostPaid.isSelected = NO;
    [_listOfNetwork addObject:ntcPostPaid];
    
    
    Network *ntcPrePaid = [Network new];
    ntcPrePaid.name = @"NTC Pre Paid";
    ntcPrePaid.prefix = @"*411*";
    ntcPrePaid.suffix = @"*10#";
    ntcPrePaid.networkID = @"ntcprepaid";
    ntcPrePaid.isSelected = NO;
    [_listOfNetwork addObject:ntcPrePaid];
    
    [self setNavigationBar];
    
    
}

- (void)setNavigationBar {
    UIBarButtonItem *doneButton       = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItems = @[doneButton];
}


- (void)done {
    //Check if user has enabled save password option
    [self.navigationController performSegueWithIdentifier:@"OCRController" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listOfNetwork.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NetworkCell *cell = (NetworkCell *)[tableView dequeueReusableCellWithIdentifier:@"NetworkCell"];
    Network *network = _listOfNetwork[indexPath.row];
    network.order = indexPath.row;
    cell.lblNetworkName.text = network.name;
    if (network.isSelected) {
        cell.imgSelected.hidden = NO;
    } else {
        cell.imgSelected.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (Network *network in _listOfNetwork) {
        if (indexPath.row == network.order) {
            network.isSelected = YES;
        } else {
            network.isSelected = NO;
        }
    }
    [tableView reloadData];
}


@end
