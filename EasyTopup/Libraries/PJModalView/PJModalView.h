//
//  PJAlertView.h
//  BeautifulAlertView
//
//  Created by Prajeet Shrestha on 3/10/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RESideMenu;
@interface PJModalView : UIView

@property (strong,nonatomic) UIViewController *popUpContainer;
@property (strong,nonatomic) UIViewController *viewControllerToAdd;
@property NSNumber *topSpaceToSuperView;
@property NSNumber *bottomSpaceToSuperView;
@property NSNumber *leadingSpaceToSuperView;
@property NSNumber *trailingSpaceToSuperView;
@property NSNumber *fixedHeight;

- (void)dismiss;
- (void)show;
- (void)showPopUpWithContainerController:(UIViewController *)containerController;

@end
