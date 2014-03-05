//
//  MainViewController.m
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DisCoverViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //调用自定义私有初始化视图方法
    [self _initViewController];
    [self _initTabbarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---初始化子控制器----
-(void)_initViewController{
    //创建视图
    HomeViewController *home = [[HomeViewController alloc] init];
    MessageViewController *message = [[MessageViewController alloc] init];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    DisCoverViewController *discover = [[DisCoverViewController alloc] init];
    MoreViewController *more = [[MoreViewController alloc] init];
    
    //创建导航控制器
    NSArray *views = @[home,message,profile,discover,more];
    NSMutableArray *viewCV = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views) {
        //创建5个导航控制器
        BaseNavigationController *baseNC = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [viewCV addObject:baseNC];
        [baseNC release],baseNC = nil;
        
    }

    self.viewControllers = viewCV;
//TODO:内存问题待解决
    
//    [home release],home = nil;
//    [message release],message = nil;
//    [profile release],profile = nil;
//    [discover release],discover = nil;
//    [more release],more = nil;
    [views release];
    
}
//初始化TabbarView--创建自定义tabbar
-(void)_initTabbarView{

    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49, 320, 49)];
    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    [self.view addSubview:_tabbarView];
    
    NSArray *bgNormal = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *bgSelect = @[@"tabbar_home_selected.png",@"tabbar_message_center_selected.png",@"tabbar_profile_selected.png",@"tabbar_discover_selected.png",@"tabbar_more_selected.png"];
    NSArray *bghightligth = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
//TODO:
    
    for (int i= 0; i<bgNormal.count; i++) {
        NSString *backImage = bgNormal[i];
        NSString *heighImage = bghightligth[i];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((64-30)/2+i*64,(49-30)/2 ,30,30);
        button.tag = i;
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:heighImage] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_tabbarView addSubview:button];
    }
    
    
    
    
    
    [_tabbarView release];



}
//实现点选
-(void)selectedTab:(UIButton *)sender{
    //获取Button值，赋给tabbar选中
    self.selectedIndex = sender.tag;
    

}

#pragma mark-实现新浪微博的协议方法-
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"%s",__FUNCTION__);
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"%s",__FUNCTION__);
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    NSLog(@"%s",__FUNCTION__);
}


@end
