//
//  TabViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TabViewController.h"
#import "HomePageVC.h"


@implementation TabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self tabV];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
}

- (void)viewDidUnload
{
    [plusView release];
    plusView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



-(UINavigationController *)tabV{
    UITabBarController *  tabBarController = [[UITabBarController alloc]init];
    HomePageVC *hot = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    hot.navigationItem.title = @"热榜";
    hot.subjectType = Hot;
    HomePageVC *news = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    news.navigationItem.title = @"42区";
    news.subjectType = News;
    HomePageVC *scoff = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    scoff.navigationItem.title = @"段子";
    scoff.subjectType = Scoff;
    HomePageVC *pic = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    pic.navigationItem.title = @"图片";
    pic.subjectType = Pic;
    
   
    
    HomePageVC *tec = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    tec.subjectType = Tec;
    HomePageVC *ask = [[HomePageVC alloc]initWithNibName:@"HomePageVC" bundle:nil];
    ask.subjectType = Ask;
    
  
    [hot.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"hot.png"]  withFinishedUnselectedImage:[UIImage imageNamed:@"hot.png"]];
    [news.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"42.png"]  withFinishedUnselectedImage:[UIImage imageNamed:@"42.png"]];
    [scoff.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"duanzi.png"]  withFinishedUnselectedImage:[UIImage imageNamed:@"duanzi.png"]];
    [pic.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"pic.png"]  withFinishedUnselectedImage:[UIImage imageNamed:@"pic.png"]];

    tabBarController.delegate = self;
    tabBarController.viewControllers = [NSArray arrayWithObjects:hot,news,scoff,pic,nil];
    [tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"]];
    
    
    //tabBarController.delegate
    //tabBarController.navigationItem.title = tabBarController.selectedViewController.navigationItem.title;
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:tabBarController];
     [tabBarController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    [navi.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    return navi;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    tabBarController.navigationItem.title = viewController.navigationItem.title;
    
}

-(void)plusButton{
    if (change) {
        NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"TabplusView" owner:self options:nil];
        // NSArray *Nib = [[NSBundle mainBundle]loadNibNamed:@"BigView" owner:self options:nil]; 
        //bigView = [Nib objectAtIndex:0];
        //得到第一个UIView  
        plusView = [nib1 objectAtIndex:0];  
        plusView.frame = CGRectMake(200, 150, 72, 42);
        [self.view addSubview:plusView];
        //[self.view addSubview:sender];
        change = NO;
    }
    else{
        [plusView removeFromSuperview];
        change = YES;
    }
    

}

- (IBAction)duanziButton:(id)sender {
  }

- (IBAction)hotButton:(id)sender {
    
}

- (void)dealloc {
    [plusView release];
    [super dealloc];
}
@end
