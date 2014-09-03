//
//  MTPMenuViewController.h
//  SwipeMenu
//
//  Created by Tomasz Popis on 12/08/14.
//  Copyright (c) 2014 Melon IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPSimpleMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHorizontalSpaceConstraint;
@property (nonatomic) CGFloat inset;

@property (nonatomic, getter=menuIsHidden) BOOL menuHidden;
- (IBAction)shiftMenu;

- (void)performMenuAnimation;

@end

