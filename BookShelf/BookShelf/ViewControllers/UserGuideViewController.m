//
//  UserGuideViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-3-1.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "UserGuideViewController.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

-(void)dealloc{
    
    [_scrollView release];
    [super dealloc];

}

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
    
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds]autorelease];
    self.scrollView.contentSize = CGSizeMake(3*320, self.view.bounds.size.height);
    for (int i=1 ;i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 *(i-1),0,self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        [imageView release],imageView = nil;
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    if (self.scrollView.contentOffset.x==0) {
        self.scrollView.showsHorizontalScrollIndicator = NO;
    }
    [self.view addSubview:self.scrollView];
    
    
    
}
#pragma mark-UIScrollView-

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//
//    if (scrollView.contentOffset.x > 700) {
//        [self.view removeFromSuperview];
//    }
//
//    
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x > 700) {
        [self.view removeFromSuperview];
    }


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
