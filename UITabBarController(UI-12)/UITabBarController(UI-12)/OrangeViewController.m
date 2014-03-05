//
//  OrangeViewController.m
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "OrangeViewController.h"

@interface OrangeViewController ()

@end

@implementation OrangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.title =@"橙色";
        UITabBarItem *orangeTab = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:3];
        self.tabBarItem = orangeTab;
        [orangeTab release],orangeTab = nil;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
