//
//  MainViewController.m
//  练习2
//
//  Created by lanou on 14-1-10.
//  Copyright (c) 2014年 蓝鸥科技. All rights reserved.
//

#import "MainViewController.h"
#import "MyScrollView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        _imageNames = [[NSMutableArray arrayWithObjects:@"h1.jpeg",
                                                        @"h2.jpeg",
                                                        @"h3.jpeg",
                                                        @"h4.jpeg",
                                                        @"h5.jpeg",
                                                        @"h6.jpeg",
                                                        @"h7.jpeg",
                                                        @"h8.jpeg",
                                                        nil] retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MyScrollView *myScorollView = [[[MyScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    [myScorollView setImagePathsInBundle:_imageNames];
    [self.view addSubview:myScorollView];
    [myScorollView setAutoRunEnableWithInterval:5];
    myScorollView.playDirection = Left;
    myScorollView.timerInterval = 2;
    myScorollView.pageControlEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
