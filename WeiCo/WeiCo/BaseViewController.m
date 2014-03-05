//
//  BaseViewController.m
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO:复写title--override
-(void)setTitle:(NSString *)title{


    [super setTitle:title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = [titleLabel autorelease];

}


//方便子类使用sinaweibo对象
-(SinaWeibo *)sinaweibo{
    //获取AppDelegate的协议
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    SinaWeibo *sinaweibo = appdelegate.sinaweibo;
//    return sinaweibo;
    return appdelegate.sinaweibo;
}


@end
