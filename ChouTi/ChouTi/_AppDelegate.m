//
//  _AppDelegate.m
//  ChouTi
//  新的
//  Created by administrator on 13-10-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "_AppDelegate.h"
#import "MoreViewController.h"
#import "HomePageVC.h"
#import "TabViewController.h"


@implementation _AppDelegate

@synthesize window = _window;
@synthesize menu;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 最底层视图－menu（MenuViewController类）
    // 第二层视图－navi（UINavigationController类）
    // 第三层视图－tabar（TabbarViewController）
    

    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(280,8,30,30)];
    [button setImage:[UIImage imageNamed:@"plus.jpg"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(plusButton) forControlEvents:UIControlEventTouchUpInside];
 
    TabViewController * tabbar = [[TabViewController alloc]init];
    /*
     UITabBarController * tabBarController  = [tabbar tabV]; 
    [tabBarController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"]];
     */
    
    
    UINavigationController * navi = [tabbar tabV];
    
       //navi.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus.jpg"] style:UIBarButtonItemStylePlain target:self action:@selector(plusButton)];
    menu = [[MenuViewController alloc] initWithRootViewController:navi];
    
    MoreViewController * more = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
    menu.leftViewController = more;
    more.currentRootview = menu.rootViewController ; 
    
    self.window.rootViewController = menu;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
    [more release];
    //[navi release];
}

- (void)applicationWillResignActive:(UIApplication *)application
{}

- (void)applicationDidEnterBackground:(UIApplication *)application
{}

- (void)applicationWillEnterForeground:(UIApplication *)application
{}

- (void)applicationDidBecomeActive:(UIApplication *)application
{}

- (void)applicationWillTerminate:(UIApplication *)application
{}

-(void)dealloc{
    [menu release];
    [super dealloc];
}
-(void)plusButton{
    
}
@end
