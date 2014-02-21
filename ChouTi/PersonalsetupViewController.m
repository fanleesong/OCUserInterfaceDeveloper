//
//  PersonalsetupViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "PersonalsetupViewController.h"
#import "OAuthWebView.h"
#import "TencentOAuthWebView.h"
//#import "RenrenOAuthWebView.h"
//#import "MainOAuhViewController.h"

#import "ZJTHelpler.h"
#import "NeicunViewController.h"
static NSString * changeTexttype = @"YES";
static BOOL BLACK = NO;
static UIWindow * window;
//static UISwitch *switchAlpha;
static NSString *userID;
static NSString * openID;
@implementation PersonalsetupViewController
@synthesize fontArr;
@synthesize token;
@synthesize lock;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  
    switchSysText = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchSysText addTarget:self action:@selector(switchSysText:) forControlEvents:UIControlEventValueChanged];
    
    switchAlpha = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchAlpha addTarget:self action:@selector(SwitchAlpha:) forControlEvents:UIControlEventValueChanged];
    
    if ([changeTexttype isEqualToString:@"YES"]) {
        [switchSysText setOn:YES];
    }
    else{
        [switchSysText setOn:NO];
    }
    
    if (BLACK) {
        [switchAlpha setOn:YES];
    }
    else{
        [switchAlpha setOn:NO];
    }
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bacg.jpg"]];
    [self.tableView setBackgroundView:tableBg];
    
    [super viewDidLoad];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [shareView release];
    shareView = nil;
    [BigView release];
    BigView = nil;
    
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserID            object:nil];
    [defaultNotifCenter removeObserver:self name:MMSinaGotUserInfo          object:nil];
    
    [defaultNotifCenter removeObserver:self name:TencentGotUserInfo    object:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    manager = [WeiBoMessageManager getInstance];
    tencentmanager = [TencentMessageManger getInstance];
    defaultNotifCenter = [NSNotificationCenter defaultCenter];
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    NSString * userName = [[NSUserDefaults standardUserDefaults]objectForKey:USER_STORE_USER_NAME];
    openID = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_ID];
  
    if (userID != nil )
    {
        [loginLock setHidden:NO];
        if (!userName) {
            [manager getUserID];
            [defaultNotifCenter addObserver:self selector:@selector(didGetUserID:)      name:MMSinaGotUserID            object:nil];
            [defaultNotifCenter addObserver:self selector:@selector(didGetUserInfo:)    name:MMSinaGotUserInfo          object:nil];
        }
        
    }
   
    if (openID != nil) {
        [loginLock setHidden:NO];
        [tencentmanager getUserInfoWithUserID:[openID longLongValue]];
        [defaultNotifCenter addObserver:self selector:@selector(didGetTencentUserInfo:)    name:TencentGotUserInfo          object:nil];
    }
       
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if ([changeTexttype isEqualToString:@"YES"]) {
        cell.textLabel.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:20];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }

    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"分享绑定";
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            break;
        case 1:
            cell.textLabel.text = @"使用自定义字体";
            cell.accessoryView = switchSysText;
            //[switchSysText release];
            break;
        case 2:
            cell.textLabel.text = @"显示图片";
            UISwitch *switchShowPic = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchShowPic addTarget:self action:@selector(SwitchAlpha:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchShowPic;
            break;
        case 3:
            cell.textLabel.text = @"夜间模式";
            cell.accessoryView = switchAlpha;
            break;
        }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置点击cell时的颜色，默认为蓝色
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    switch (indexPath.row) {
        case 0:
        {
            NSArray * Basenib = [[NSBundle mainBundle]loadNibNamed:@"FullScreenView" owner:self options:nil];  
             BigView = [Basenib objectAtIndex:0];
            BigView.frame = self.view.window.frame;
            BigView.backgroundColor = [UIColor blackColor];
            [BigView setAlpha:0.3];
            [self.view addSubview:BigView];
            
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"SharView" owner:self options:nil];  
            shareView = [nib objectAtIndex:0];
            shareView.frame = CGRectMake(90, 60, 180,243);
            [self.view addSubview:shareView];
            
           //添加关闭按钮
            closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [closeButton addTarget:self action:@selector(cancel)
                  forControlEvents:UIControlEventTouchUpInside];
            closeButton.showsTouchWhenHighlighted = YES;
            closeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            closeButton.frame = CGRectMake(86, 57, 30, 30);
            [self.view addSubview:closeButton];     
            
            
            loginLock = [UIButton buttonWithType:UIButtonTypeCustom];
            [loginLock setImage:[UIImage imageNamed:@"right.jpg"] forState:UIControlStateNormal];
            [loginLock setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [loginLock addTarget:self action:@selector(cancelLock)
                forControlEvents:UIControlEventTouchUpInside];
            loginLock.showsTouchWhenHighlighted = YES;
            loginLock.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            loginLock.frame = CGRectMake(240, 58, 30, 30);
            [self.view addSubview:loginLock];
            
            
            NSLog(@"%@",userID);
            if (userID != nil || openID !=nil)
            {
                [loginLock setHidden:NO];
            }
            else
                [loginLock setHidden:YES];
           
        }
            break;
            
//        case 1://缓存清理
//        {
//            NeicunViewController * neicun = [[NeicunViewController alloc]initWithNibName:@"NeicunViewController" bundle:nil]; 
//            [self.navigationController pushViewController:neicun animated:YES];
//            // [self clear];
//            [neicun release];
//        }
//            break;
    }
}

- (void)SwitchAlpha:(id)sender {
    
    
    UISwitch *switchView = (UISwitch *)sender;
    
    if ([switchView isOn]) 
    {
        //[UIScreen mainScreen].brightness = 0.5;
        
        window = [[UIWindow alloc] initWithFrame:self.view.window.frame];  
        window.windowLevel = UIWindowLevelStatusBar + 1;  
        window.userInteractionEnabled = NO;  
        window.backgroundColor = [UIColor blackColor];  
        window.alpha = 0.5;  
        window.hidden = NO;  

        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];//防止休眠
        BLACK = YES;
    } 
    else 
    {
        window.hidden = YES;
        BLACK = NO;
    }
    
}

-(void)switchSysText:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
   
    if ([switchView isOn])
    {
        changeTexttype = @"YES";
        [switchView setOn:YES];
        [self.tableView reloadData];
       
        
    }
    else{
        changeTexttype = @"NO";
       [switchView setOn:NO];
        [self.tableView reloadData];
    }
    
    NSNotification *notification = [NSNotification notificationWithName:CHANGEFONTTYPE object:changeTexttype];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

-(void)cancel{
    [BigView removeFromSuperview];
    [shareView removeFromSuperview];
    [closeButton setHidden:YES];
    [loginLock setHidden:YES];
}

-(void)cancelLock{
   
    [loginLock setHidden:YES];
    if (userID != nil) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Sinna_USER_STORE_ACCESS_TOKEN];//问题1：登录微薄返回后点即取消绑定会在这个地方崩
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
        userID = nil;
        
     }
    if (openID != nil ) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_ACCESS_TOKEN];//问题1：登录微薄返回后点即取消绑定会在这个地方崩
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_OPEN_ID];
         [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_OPEN_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        openID = nil;
    }
     
}

- (void)dealloc {
    [shareView release];
    [BigView release];
    [super dealloc];
}

- (IBAction)sinnaButton:(id)sender {
    
    OAuthWebView * web = [[OAuthWebView alloc]initWithNibName:@"OAuthWebView" bundle:nil];
    [self.navigationController pushViewController:web animated:YES];
    [web release];
}

- (IBAction)tengxunButton:(id)sender {
    TencentOAuthWebView * tencent = [[TencentOAuthWebView alloc]initWithNibName:@"TencentOAuthWebView" bundle:nil];
    [self.navigationController pushViewController:tencent animated:YES];
    [tencent release];
    
}

- (IBAction)renrenButton:(id)sender {
    //RenrenOAuthWebView * renren =[[RenrenOAuthWebView alloc]initWithNibName:@"RenrenOAuthWebView" bundle:nil];
    //[self.navigationController pushViewController:renren animated:YES];
    //[renren release];
    
//    MainOAuhViewController *RENREN = [[MainOAuhViewController alloc]initWithNibName:@"" bundle:nil];
//    [self.navigationController pushViewController:RENREN animated:YES];
//    [RENREN release];
}


-(void)didGetUserID:(NSNotification*)sender
{
     NSString * userid = sender.object;
    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [manager getUserInfoWithUserID:[userid longLongValue]];
}

-(void)didGetUserInfo:(NSNotification*)sender
{
    SinaUser *user = sender.object;
    [ZJTHelpler getInstance].user = user;
    [[NSUserDefaults standardUserDefaults] setObject:user.screenName forKey:USER_STORE_USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)didGetTencentUserInfo:(NSNotification*)sender
{
    SinaUser *user = sender.object;
    [ZJTHelpler getInstance].user = user;
    [[NSUserDefaults standardUserDefaults] setObject:user.screenName forKey:USER_STORE_USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
