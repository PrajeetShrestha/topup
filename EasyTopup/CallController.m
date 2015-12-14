//
//  CallController.m
//  EasyTopup
//
//  Created by Prajeet Shrestha on 12/15/15.
//  Copyright © 2015 Eeposit1. All rights reserved.
//

#import "CallController.h"

@implementation CallController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = [NSString stringWithFormat:@"%@%@%@",_selectedNetwork.prefix,_extractedPinCode,_selectedNetwork.suffix];;
    self.lblFullNumber.text = [NSString stringWithFormat:@"%@%@%@",_selectedNetwork.prefix,_extractedPinCode,_selectedNetwork.suffix];
    [self.textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.lblFullNumber.text = [NSString stringWithFormat:@"%@",_extractedPinCode];
}

- (IBAction)call:(id)sender {
    //    CallController
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt://%@",_textField.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
        NSLog(@"Can Call");
    } else
    {
        NSLog(@"Can't Call");
    }
}
@end
