//
//  AddNewNetworkViewController.m
//  EasyTopup
//
//  Created by Prajeet Shrestha on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import "AddNewNetworkViewController.h"

@implementation AddNewNetworkViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [_confirm setOn:NO];
}
- (IBAction)confirmAction:(id)sender {
    UISwitch *swControl = (UISwitch *)sender;
    if (swControl.isOn) {
        NSLog(@"On");
    } else {
        NSLog(@"Off");
    }
}
@end
