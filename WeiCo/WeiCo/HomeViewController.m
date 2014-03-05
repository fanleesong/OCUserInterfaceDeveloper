//
//  HomeViewController.m
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initDelegateButton];
}
//初始化授权按钮
-(void)_initDelegateButton{

    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindItemAction:)];
    self.navigationItem.rightBarButtonItem =[bindItem autorelease];
    UIBarButtonItem *cancelbindItem = [[UIBarButtonItem alloc] initWithTitle:@"注销账号" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelbindItemAction:)];
    self.navigationItem.leftBarButtonItem =[cancelbindItem autorelease];
    //判断是否认证
    if (self.sinaweibo.isAuthValid) {
        //加载
        [self loadWeiboData];
    }
}
#pragma mark--
-(void)loadWeiboData{

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"5" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          delegate:self];

}
//实现代理方法
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{

    NSLog(@"网络加载失败%@",error);

}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    NSLog(@"%@",result);
}


#pragma mark-Action Bind-
//绑定
-(void)bindItemAction:(UIBarButtonItem *)sender{

    //调用sinaweibo的SDK的登陆方法
    [self.sinaweibo logIn];
    

}
//注销
-(void)cancelbindItemAction:(UIBarButtonItem *)sender{

    //调用sinaweibo的SDK的注销方法
    [self.sinaweibo logOut];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
