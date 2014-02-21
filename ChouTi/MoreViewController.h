//
//  MoreViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "HTTPMessageManager.h"
#import "User.h"

@interface MoreViewController : UITableViewController<UIGestureRecognizerDelegate>{
    BOOL login;
    NSMutableArray * arrayOfSections;
    
    LoginViewController * logi;
    UIViewController * currentRootview;
    
    IBOutlet UIView *BigView;
     MenuViewController * menu;
    
    HTTPMessageManager *manager;
    NSDictionary *countDic;
    }
@property(retain,nonatomic) UIViewController * currentRootview;
@property(retain,nonatomic) NSDictionary *countDic;

//- (void)showShadow:(BOOL)val;
-(void)mineView;
-(void)sendView;
-(void)personSet;
-(void)rangeList;
-(void)tabbarPage;
-(void)aitiPage;
-(void)askPage;
-(void)changeType:(NSNotification *)sender;

- (void)didGetUserInfo:(NSNotification*)sender;

@end


