//
//  RedViewController.m
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "RedViewController.h"
#import "YellowViewController.h"
#import "AppDelegate.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title =@"红色";
        UITabBarItem *redTab = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1];
        self.tabBarItem = redTab;
        [redTab release],redTab = nil;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
	// Do any additional setup after loading the view.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 40);
    button.backgroundColor = [UIColor whiteColor];
    button.center = self.view.center;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取新浪SSO认证" style:UIBarButtonItemStyleBordered target:self action:@selector(getSinaweiboAuthenticate:)];
    
    
    
}
//实现新浪授权
#pragma mark --实现新浪授权--
-(void)getSinaweiboAuthenticate:(UIBarButtonItem *)sender{


    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];



}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"收到网络回调";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = @"请求异常";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
}



-(void)handleButtonAction:(UIButton *)sender{

    YellowViewController *yellow = [[YellowViewController alloc] init];
    
    //在试图控制器入栈显示时，隐藏底部bar
    yellow.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:yellow animated:YES];
    [yellow release],yellow = nil;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
