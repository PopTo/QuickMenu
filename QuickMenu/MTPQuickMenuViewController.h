//
//  MTPQuickMenuViewController.h
//  QuickMenu
//
//  Created by Tomasz Popis on 12/08/14.
//  Copyright (c) 2014 Melon IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTPQuickMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHorizontalSpaceConstraint;

@property (nonatomic, getter=menuIsHidden) BOOL menuHidden;
- (IBAction)shiftMenu;

- (void)performMenuAnimation;

@end

