//
//  ViewController.m
//  Demo
//
//   Created by MartinLi on 11-02-24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [self setupViews];
	// Do any additional setup after loading the view, typically from a nib.
}
#pragma mark -
- (void)setupViews
{
    NSMutableArray *imgUrls = [[NSMutableArray alloc] init];
    EScrollerView *scroller;
    
    //页面个数
    NSInteger count = 5;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for(int i=0;i<count;i++)
    {
        [imgUrls addObject:@"http://old.dongway.com.cn/picture/indexdatapic/2013-12/02/220d0bf6-bbf7-4a7e-b27b-80e3fdcaae8b.png"];
        [titles addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    
    scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 20, 320, 150)
                                           ImageArray:imgUrls
                                           TitleArray:titles];
    scroller.delegate=self;
    [self.view addSubview:scroller];
    
    [scroller release];

}
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%d",index);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
