//
//  BlueViewController.m
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.title =@"蓝色";
        UITabBarItem *blueTab = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2];
        self.tabBarItem = blueTab;
        [blueTab release],blueTab = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.5;
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"测试" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(30, 300, 200, 78);
    [self.view addSubview:addButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
