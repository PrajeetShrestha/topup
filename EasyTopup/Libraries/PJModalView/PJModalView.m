//
//  PJAlertView.m
//  BeautifulAlertView
//
//  Created by Prajeet Shrestha on 3/10/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import "PJModalView.h"


#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PJModalView ()
{
    NSLayoutConstraint *centerVerticallyToSuperView;
    
    NSLayoutConstraint *centerHorizontallyToSuperView;
    
    UIView *backView;
}
@end

@implementation PJModalView



- (id)init
{
    self = [super init];
    if (self)
    {
        self = [self getPJViewFromMainBundle];
        
        [self makeCommonInitializations];
    }
    return self;
}


-(PJModalView *)getPJViewFromMainBundle
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"PJModalView"
                                                      owner:nil
                                                    options:nil];
    
    return (PJModalView *)[nibViews objectAtIndex:0];
}

-(void)makeCommonInitializations
{
    backView = [UIView new];
    
    backView.backgroundColor = [UIColor blackColor];
    
    backView.alpha = 0.3f;
    
    UITapGestureRecognizer *backViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(backViewTapped:)];
    [backView addGestureRecognizer:backViewTap];

    UISwipeGestureRecognizer *backViewSwipe =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(backViewSwiped:)];

    [backViewSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [backView addGestureRecognizer:backViewSwipe];

    backView.userInteractionEnabled = YES;
}

- (void)backViewSwiped:(id)sender {
    [self dismiss];
}
-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication]windows][0];
    
    backView.frame = window.rootViewController.view.frame;
    
    [window.rootViewController.view addSubview:backView];
    
    [window.rootViewController.view layoutIfNeeded];
    
    [window.rootViewController.view addSubview:self];
    
    [self setSelfConstraintWithRespectToViewOfViewController:self];
    
    [self setShadow:self];
    
    [self beginAnimations];
 }

- (void)backViewTapped:(UITapGestureRecognizer *)recognizer {
    [self dismiss];
}


-(void)showPopUpWithContainerController:(UIViewController *)containerController
{
    UIWindow *window = [[UIApplication sharedApplication]windows][0];

    backView.frame = window.rootViewController.view.frame;
    
    [window.rootViewController.view addSubview:backView];
    
    [window.rootViewController.view layoutIfNeeded];
    
    [window.rootViewController.view addSubview:self];


    _viewControllerToAdd = containerController;
    
    containerController.view.frame = self.bounds;
    
    [containerController willMoveToParentViewController:window.rootViewController];
    
    [self addSubview:containerController.view];
    
    [window.rootViewController addChildViewController:containerController];
    
    [containerController didMoveToParentViewController:window.rootViewController];
    
    if (_fixedHeight == nil) {
        [self setSelfConstraintWithRespectToViewOfViewController:self];
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self setConstraintCenteredWithWidth:@522 andHeight:_fixedHeight forView:self];
        } else
            [self setConstraintCenteredWithHeight:_fixedHeight forView:self];
    }
    
    [self layoutSubviews];
    [self setShadow:self];
    
    [self beginAnimations];
    
}

- (void)layoutSubviews {
    if (_fixedHeight == nil) {
        [self setSelfConstraintWithRespectToViewOfViewController:self];
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self setConstraintCenteredWithWidth:@522 andHeight:_fixedHeight forView:self];
        } else
            [self setConstraintCenteredWithHeight:_fixedHeight forView:self];
    }
    
}

- (void)setConstraintCenteredWithWidth:(NSNumber *)width andHeight:(NSNumber*)height forView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    centerVerticallyToSuperView = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0
                                   ];
    
    centerHorizontallyToSuperView = [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.superview
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1
                                                                  constant:0
                                     ];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:_fixedHeight.floatValue]];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:width.floatValue]];
    
    
    
    [self.superview addConstraint:centerVerticallyToSuperView];
    [self.superview addConstraint:centerHorizontallyToSuperView];
}

- (void)setConstraintCenteredWithHeight:(NSNumber *)height forView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDictionary = @{@"PJModalView":view};
    
    if (_bottomSpaceToSuperView == nil) {
        _bottomSpaceToSuperView = @0;
    }
    
    if (_leadingSpaceToSuperView == nil) {
        _leadingSpaceToSuperView = @0;
    }
    
    if (_topSpaceToSuperView == nil) {
        _topSpaceToSuperView = @0;
    }
    
    if (_trailingSpaceToSuperView == nil) {
        _trailingSpaceToSuperView = @0;
    }
    
    NSDictionary *metrics =@{@"topSpaceToSuperView":_topSpaceToSuperView,
                             @"bottomSpaceToSuperView":_bottomSpaceToSuperView,
                             @"leadingSpaceToSuperView":_leadingSpaceToSuperView,
                             @"trailingSpaceToSuperView":_trailingSpaceToSuperView
                             };
    
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leadingSpaceToSuperView-[PJModalView]-trailingSpaceToSuperView-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:viewsDictionary];
    
    
    
    centerVerticallyToSuperView = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0
                                   ];
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:_fixedHeight.floatValue]];
    
    
    [self.superview addConstraints:widthConstraint];
    [self.superview addConstraint:centerVerticallyToSuperView];
}

-(void)setSelfConstraintWithRespectToViewOfViewController:(UIView *)view
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDictionary = @{@"PJModalView":view};
    
    if (_bottomSpaceToSuperView == nil) {
        _bottomSpaceToSuperView = @0;
    }
    
    if (_leadingSpaceToSuperView == nil) {
        _leadingSpaceToSuperView = @0;
    }
    
    if (_topSpaceToSuperView == nil) {
        _topSpaceToSuperView = @0;
    }
    
    if (_trailingSpaceToSuperView == nil) {
        _trailingSpaceToSuperView = @0;
    }
    
    NSDictionary *metrics =@{@"topSpaceToSuperView":_topSpaceToSuperView,
                             @"bottomSpaceToSuperView":_bottomSpaceToSuperView,
                             @"leadingSpaceToSuperView":_leadingSpaceToSuperView,
                             @"trailingSpaceToSuperView":_trailingSpaceToSuperView
                             };
    
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leadingSpaceToSuperView-[PJModalView]-trailingSpaceToSuperView-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:viewsDictionary];
    
    NSArray *height = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topSpaceToSuperView-[PJModalView]-bottomSpaceToSuperView-|"
                                                              options:0
                                                              metrics:metrics
                                                                views:viewsDictionary];
    
    //
    [self.superview addConstraints:widthConstraint];
    [self.superview addConstraints:height];
}

-(void)setShadow:(UIView *)view
{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    
    view.layer.shadowRadius = 2;
    
    view.layer.shadowOpacity = 0.7;
    
    view.layer.cornerRadius = 5.0f;
    
    view.clipsToBounds = YES;

}

-(void)beginAnimations
{
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    [UIView animateWithDuration:0.2 animations:^(void){
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismiss
{
    [_viewControllerToAdd willMoveToParentViewController:nil];
    [_viewControllerToAdd.view removeFromSuperview];
    [_viewControllerToAdd removeFromParentViewController];
    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.2f animations:^(void)
     {
         backView.alpha = 0.0f;
         
     }completion:^(BOOL finished){
         
         [backView removeFromSuperview];
     }];
//    UIWindow *window = [[UIApplication sharedApplication]windows][0];
//    if([window.rootViewController isKindOfClass:[RESideMenu class]]) {
//        RESideMenu * menu = (RESideMenu *)window.rootViewController;
//        menu.panGestureEnabled = YES;
//
//    }


    
}

@end
