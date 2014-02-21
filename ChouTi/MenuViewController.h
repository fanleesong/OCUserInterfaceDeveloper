//
//  MenuViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    GesDirectionLeft = 0,
    GesDirectionRight,
} PanDirection;

typedef enum {
    GesCompletionLeft = 0,
    GesCompletionRight,
    GesCompletionRoot,
} PanCompletion;

@protocol MenuDelegate;
@interface MenuViewController : UIViewController<UIGestureRecognizerDelegate>{
    id click;
    id gesture;
    
    CGFloat gestureOriginX;
    CGPoint gestureVelocity;
    PanDirection GesDirection;
    
    struct {
        unsigned int respondsToWillShowViewController:1;
        unsigned int showingLeftView:1;
        unsigned int showingRightView:1;
        unsigned int canShowRight:1;
        unsigned int canShowLeft:1;
    } _menuFlags;
}

@property(nonatomic,assign) id <MenuDelegate> delegate;
@property(nonatomic,strong) UIViewController *leftViewController;
@property(nonatomic,strong) UIViewController *rightViewController;
@property(nonatomic,strong) UIViewController *rootViewController;
@property(nonatomic,readonly) UITapGestureRecognizer *click;
@property(nonatomic,readonly) UIPanGestureRecognizer *gesture;

- (id)initWithRootViewController:(UIViewController*)controller;
- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated; // used to push a new controller on the stack
- (void)showRootController:(BOOL)animated; // reset to "home" view controller
- (void)showRightController:(BOOL)animated;  // show right
- (void)showLeftController:(BOOL)animated;  // show left
//- (void)showShadow:(BOOL)val;
@end

@protocol MenuDelegate 
- (void)menuController:(MenuViewController *)controller willShowViewController:(UIViewController*)controller;
@end
