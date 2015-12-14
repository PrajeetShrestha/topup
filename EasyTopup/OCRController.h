//
//  OCRController.h
//  Template Framework Project
//
//  Created by Eeposit1 on 12/3/15.
//  Copyright © 2015 Daniele Galiotto - www.g8production.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>
#import "ImageCropView.h"
#import "Network.h"
#import "AppDelegate.h"
#import "PJModalView.h" 
#import "CallController.h"

@interface OCRController : UIViewController<G8TesseractDelegate,ImageCropViewControllerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic) UIImage *croppedImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) Network *selectedNetwork;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
