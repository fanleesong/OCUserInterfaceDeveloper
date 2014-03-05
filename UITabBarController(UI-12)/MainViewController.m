//
//  MainViewController.m
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "MainViewController.h"
#import "RedViewController.h"
#import "OrangeViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"
#import "CyanViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self _initViewController];
}
#pragma mark---初始化子控制器----
-(void)_initViewController{
    //创建视图
    RedViewController *red = [[RedViewController alloc] init];
    YellowViewController *yellow = [[YellowViewController alloc] init];
    BlueViewController *blue = [[BlueViewController alloc] init];
    CyanViewController *cyan = [[CyanViewController alloc] init];
    OrangeViewController *orange = [[OrangeViewController alloc] init];
    
    //创建导航控制器
    NSArray *views = @[red,yellow,blue,cyan,orange,cyan];
    NSMutableArray *viewCV = [NSMutableArray arrayWithCapacity:6];
    for (UIViewController *viewController in views) {
        //创建5个导航控制器
        UINavigationController *baseNC = [[UINavigationController alloc] initWithRootViewController:viewController];
        [viewCV addObject:baseNC];
        [baseNC release],baseNC = nil;
        
    }
    
    self.viewControllers = viewCV;
    
//    self.viewControllers = [NSArray arrayWithObjects:red,yellow,blue,cyan,orange, nil];
    [red release],red =nil;
    [blue release],blue = nil;
    [cyan release],cyan = nil;
    [yellow release], yellow  = nil;
    [orange release],orange = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
