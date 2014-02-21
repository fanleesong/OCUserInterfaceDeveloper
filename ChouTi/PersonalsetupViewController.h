//
//  PersonalsetupViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TencentMessageManger.h"
#import "WeiBoMessageManager.h"

#define CHANGEFONTTYPE  @"change"

@interface PersonalsetupViewController : UITableViewController{
    
    NSArray * fontArr;
    
    IBOutlet UIView *shareView;
    IBOutlet UIView *BigView;
    UIButton * closeButton;
    
    UIButton * loginLock;
    
    NSNotificationCenter *defaultNotifCenter;
    TencentMessageManger *tencentmanager;
    WeiBoMessageManager * manager;
   
    
    BOOL  shouldLoad;
   UISwitch *switchSysText;
    UISwitch *switchAlpha;
}
@property(retain,nonatomic)NSArray * fontArr;
@property(assign,nonatomic)NSString * token;
@property(retain,nonatomic)NSString * lock;
@property (nonatomic, copy)NSString *userID;
- (IBAction)sinnaButton:(id)sender;
- (IBAction)tengxunButton:(id)sender;
- (IBAction)renrenButton:(id)sender;
-(void)changeType:(NSNotification *)sender;
@end
