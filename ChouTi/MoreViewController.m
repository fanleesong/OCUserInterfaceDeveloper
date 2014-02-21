//
//  MoreViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "MenuViewController.h"
#import "_AppDelegate.h"
#import "LoginViewController.h"
#import "PersonalsetupViewController.h"
#import "MineViewController.h"
#import "SendViewController.h"
#import "TabViewController.h"
#import "HomePageVC.h"
//static NSS fontType = YES;
static NSString *fontType = @"YES";
@implementation MoreViewController
@synthesize currentRootview;
@synthesize countDic;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    menu = (MenuViewController *)((_AppDelegate *)[[UIApplication sharedApplication] delegate]).menu;
    logi = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
 
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bacg.jpg"]];
    [self.tableView setBackgroundView:tableBg];
    [tableBg release];                                
    [super viewDidLoad];
    
    manager = [HTTPMessageManager getInstance];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetUserInfo:) name:GotUserInfo object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeType:) name:CHANGEFONTTYPE object:nil];
    [manager getUserInfo];
}

- (void)didGetUserInfo:(NSNotification*)sender{
    self.countDic = sender.object;
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        currentRootview.view.userInteractionEnabled = YES;
        [menu setRootController:currentRootview animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [[self view] addGestureRecognizer:recognizer];
    [recognizer release];
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 NSInteger result = 0;
    if (!login) {
        result = 3;
       // 我的、消息、发布 
        //排行榜、设置、关于抽屉
        //退出
    }
    else{
       result = 2; 
        //登录、排行榜、
        //设置、关于抽屉
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger result = 0; 
    //若为登录状态，分为三个部分
    if (!login) {
        if ([tableView isEqual:self.tableView])
        {
            switch (section)
            {
                case 0: 
                    result=3; //第一个section则显示三行数据 (我的）
                    break; 
                case 1: 
                    result = 2;
                    break; 
                case 2:
                    result = 2;
                    break;
            } 
        } 
    }
    else{
        if ([tableView isEqual:self.tableView])
        {
            switch (section)
            {  
                case 0: 
                    result=3; //第一个section显示3行 （登录、抽屉榜、排行榜）
                    break; 
                case 1: 
                    result = 2; //第二个section显示2行数据 （个人设置、关于抽屉）
                    break; 
                    
            } 
        } 

    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //static NSString *CellIdentifier = @"Cell";
    static NSString *CustomCellIdentifier =@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
   
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier] autorelease];
      
    }
    if ([fontType isEqualToString:@"YES"]) {
        cell.textLabel.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:20];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        
    }
    
    
    if (!login) {
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的";
                    break;
                case 1:
                    cell.textLabel.text = @"发布";
                    break;
                case 2:
                    cell.textLabel.text = @"打开抽屉";
                    break;
               
            }
        }
        else if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"挨踢";
                    break;
                case 1:
                    cell.textLabel.text = @"你问我答";
                    break;
            }
        }
        else if(indexPath.section ==2){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"个人设置";
                    break;
                case 1:
                    cell.textLabel.text = @"关于抽屉";
                    break;
            }
            
        }
    }
    else{
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"登录";
                    break;
                 case 1:
                    cell.textLabel.text = @"返回抽屉";
                    break;
                default:
                    cell.textLabel.text = @"排行榜";
                    break;
            }
        }
        else{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"设置";
                    break;
                    
                default:
                    cell.textLabel.text = @"关于抽屉";
                    break;
            }
  
        }
      }
 
    return cell;
  
    
       
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //
    if (!login) {
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0://“我的”页面
                    [self mineView]; 
                    break;
                case 1://“发布”页面
                    [self sendView];
                    break;
                case 2://返回“抽屉”
                   [self tabbarPage];
                    break;
               
            }
        }
        else if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0://"挨踢"
                    [self aitiPage];
                    break;
                case 1:
                    [self askPage];
                    break;
            }
        }
        else if(indexPath.section ==2){
            switch (indexPath.row) {
                case 0://“排行榜”
                    [self personSet];
                    break;
                case 1://“个人设置”
                   
                    break;
            }
            
        }
        else if(indexPath.section ==3){
            switch (indexPath.row) {
                case 0:
                    
                    break;
                    
            }
            
            
        }
    }
    
    //未登录
    else{
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:  //进入登录页面
                {
                    LoginViewController * log = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                    UINavigationController * navi1 = [[UINavigationController alloc]initWithRootViewController:log];
                    //currentRootview = navi;
                    navi1.navigationItem.title = @"登录";
                    [menu setRootController:navi1 animated:YES];
                    [log release];
                    //[navi1 release];
                }
                   break;
                case 1: //进入抽屉tabbar页面
                    [self tabbarPage];
                    break;
                case 2: //排行榜页面
                    break;
            }
        }
        
        if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:  //个人设置页
                {
                    [self personSet];                                                         
                }
                    break;
                    
                case 1://关于抽屉
                   
                    break;
            }
            
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)tabbarPage{
    
    TabViewController * tab = [[TabViewController alloc]init];
    //UITabBarController * tabBarController = [tab tabV];
    UINavigationController * navi = [tab tabV];
    [menu setRootController:navi animated:YES];
   

}

-(void)aitiPage{
    HomePageVC *tec = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    tec.subjectType = Tec;
     tec.navigationItem.title = @"挨踢";
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:tec];
    [tec.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [menu setRootController:navi animated:YES];
}

-(void)askPage{
    HomePageVC *ask = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    ask.subjectType = Ask;
    ask.navigationItem.title = @"你问我答";
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:ask];
    [ask.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [menu setRootController:navi animated:YES];
}

-(void)personSet{
        PersonalsetupViewController * setup = [[PersonalsetupViewController alloc]initWithNibName:@"PersonalsetupViewController" bundle:nil];
    setup.navigationItem.title = @"个人设置";
        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:setup];
        //currentRootview = navi;
        [menu setRootController:navi animated:YES];
        [setup release];

}

-(void)mineView{
    MineViewController * mine = [[MineViewController alloc]initWithNibName:@"MineViewController" bundle:nil];
    mine.dic = countDic;
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:mine];
    [menu setRootController:navi animated:YES];
    [mine release];
}

-(void)sendView{
    SendViewController * send = [[SendViewController alloc]initWithNibName:@"SendViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:send];
    [menu setRootController:navi animated:YES];
    [send release];
}



-(void)changeType:(NSNotification *)sender{
    fontType = sender.object;
    if ([fontType isEqualToString:@"YES"]) {
        [self.tableView reloadData];
        //fontType = NO;
    }
    else{
        [self.tableView reloadData];
        //fontType = YES;
    }
}

////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [super dealloc];
}

@end