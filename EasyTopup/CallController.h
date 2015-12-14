//
//  CallController.h
//  EasyTopup
//
//  Created by Prajeet Shrestha on 12/15/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJModalView.h"
#import "Network.h"

@interface CallController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblFullNumber;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) NSString *extractedPinCode;
@property (nonatomic) PJModalView    *modalView;
@property (nonatomic) Network *selectedNetwork;
- (IBAction)call:(id)sender;

@end
