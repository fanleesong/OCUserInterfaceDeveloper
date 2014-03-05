//
//  CyanViewController.m
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "CyanViewController.h"

@interface CyanViewController ()

@end

@implementation CyanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.title =@"青色";
        UITabBarItem *cyanTab = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:4];
        self.tabBarItem = cyanTab;
        [cyanTab release],cyanTab = nil;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
