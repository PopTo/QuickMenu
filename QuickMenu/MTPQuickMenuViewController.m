//
//  MTPQuickMenuViewController.m
//  QuickMenu
//
//  Created by Tomasz Popis on 12/08/14.
//  Copyright (c) 2014 Melon IT. All rights reserved.
//

#import "MTPQuickMenuViewController.h"
@interface MTPQuickMenuViewController () {
}

- (void)setupMenuGestures;
- (void)switchMenuGestureDirection;
- (CGFloat)menuDestinationXPos;

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)gesture;
- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture;

@end

@implementation MTPQuickMenuViewController {
  BOOL menuViewIsHidden;
  UISwipeGestureRecognizer *shiftMenuGesture;
  UIScreenEdgePanGestureRecognizer *menuEdgePanGesture;
}

#pragma mark Initializing
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if(self != nil) {
    menuViewIsHidden = YES;
  }
  
  return self;
}

#pragma mark Overriding UIViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupMenuGestures];
  self->_menuHorizontalSpaceConstraint.constant = [self menuDestinationXPos];
}

#pragma mark Showing Menu
- (void)setMenuHidden:(BOOL)menuHidden {
  
  if(self->menuViewIsHidden != menuHidden) {
    self->menuViewIsHidden = menuHidden;
    [self switchMenuGestureDirection];
    [self performMenuAnimation];
  }
}

- (BOOL)menuIsHidden {
  return self->menuViewIsHidden;
}

- (IBAction)shiftMenu {
  self.menuHidden = !self.menuHidden;
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)gesture {
  [self shiftMenu];
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
  
  if(gesture.state == UIGestureRecognizerStateBegan) {
    self.menuHidden = NO;
  }
}

#pragma mark Animating Menu
- (void)performMenuAnimation {
  
  CGFloat destinationXPos = [self menuDestinationXPos];
  [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
  
  [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
    self.menuHorizontalSpaceConstraint.constant = destinationXPos;
    [self.view layoutIfNeeded];
    
  } completion:^(BOOL finished) {
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
  }];
}

#pragma mark Private - Positioning Menu
- (CGFloat)menuDestinationXPos {
  
  CGFloat destinationXPos = 0;
  
  if(self->menuViewIsHidden == YES) {
    destinationXPos = -self->_menuWidthConstraint.constant;
  }
  
  return destinationXPos;
}


#pragma mark Private - Setup Gestures
- (void)setupMenuGestures {
  
  self->shiftMenuGesture =
  [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSwipeGesture:)];
  self->menuEdgePanGesture =
  [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleEdgePanGesture:)];
  
  switch (self->_menuHorizontalSpaceConstraint.firstAttribute) {
      
    case NSLayoutAttributeLeading: {
      self->menuEdgePanGesture.edges = UIRectEdgeLeft;
      
      if(self->menuViewIsHidden == NO) {
        self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
      }
      else {
        self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
      }
      break;
    }
      
    case NSLayoutAttributeTrailing: {
      self->menuEdgePanGesture.edges = UIRectEdgeRight;
      
      if(self->menuViewIsHidden == NO) {
        self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
      }
      else {
        self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
      }
      break;
    }
      
    default: {
      break;
    }
  }
  
  [self.view addGestureRecognizer:self->menuEdgePanGesture];
  [self.menuView addGestureRecognizer:self->shiftMenuGesture];
}

- (void)switchMenuGestureDirection {
  
  switch(self->shiftMenuGesture.direction) {
      
    case UISwipeGestureRecognizerDirectionLeft: {
      self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
      break;
    }
      
    case UISwipeGestureRecognizerDirectionRight: {
      self->shiftMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
      break;
    }
      
    default: {
      break;
    }
  }
}

@end
