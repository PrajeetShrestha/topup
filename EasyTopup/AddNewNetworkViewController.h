//
//  AddNewNetworkViewController.h
//  EasyTopup
//
//  Created by Prajeet Shrestha on 12/14/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJModalView.h"
@interface AddNewNetworkViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *confirm;
- (IBAction)confirmAction:(id)sender;

@property (nonatomic) PJModalView   *modalView;
@end
