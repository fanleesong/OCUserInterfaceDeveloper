//
//  BaseNavigationController.m
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BaseNavigationController.h"
//#import "WXHLGlobalUICommon.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
    //通过判断版本使用不同的系统方法
    
    float version = WXHLOSVersion();
    if (version >= 5.0) {
        NSLog(@"%f",version);
        
        UIImage *image = [UIImage imageNamed:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }
//    if (self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)) {
//        
//    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
