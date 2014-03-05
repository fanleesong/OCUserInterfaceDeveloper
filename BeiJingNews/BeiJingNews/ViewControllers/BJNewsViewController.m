//
//  BJNewsViewController.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJNewsViewController.h"
#import "UIImageView+WebCache.h"
#import "BJHeaderScrollView.h"
#import "BJNewsItemCell.h"
#import "BJNewsRequest.h"
#import "BJActivityCell.h"
#import "BJNewsItem.h"

@interface BJNewsViewController ()<NewsRequestDelegate,UIScrollViewDelegate>

@property(nonatomic,retain) NSMutableArray *newsListArray;//提供数据源数组
@property (nonatomic,retain) BJHeaderScrollView *headerScrollView;
@property (nonatomic,assign) BOOL isRefreshing;//标记当前是否正在刷新数据
@property (nonatomic,assign) NSInteger pageIndex;//记录当前加载的是第几个分页数据


-(void)_aquireWebDataWithParams:(NSDictionary *)paramDic;

@end

@implementation BJNewsViewController

-(void)dealloc{
    
    [_newsListArray release];
    [super dealloc];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageIndex = 1;//标示为第一个页面
    
    
    /*
     date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213
    
    //实例化参数字典
    NSMutableDictionary *pramasDic = [NSMutableDictionary dictionary];
    [pramasDic setObject:@"20131129" forKey:@"date"];
    [pramasDic setObject:@"1" forKey:@"startRecord"];
    [pramasDic setObject:@"10" forKey:@"len"];
    [pramasDic setObject:@"1234567890" forKey:@"udid"];
    [pramasDic setObject:@"Iphone" forKey:@"terminalType"];
    [pramasDic setObject:@"213" forKey:@"cid"];

    
    //调用初始化
    [self _aquireWebDataWithParams:pramasDic];
     
     */

    //直接调用封装后的方法
    [self startRefreshWebData];
    
    
    //下拉刷新数据
    //一旦refreshCotrol属性赋值，则在表示图往下拖拽显示旋转图标，表示正在刷新数据
    self.refreshControl = [[[UIRefreshControl alloc] init] autorelease];
    //由于下拉刷新时refreshControl的状态会发生改变，因此使用UIControlEventValueChanged
    [self.refreshControl addTarget:self action:@selector(startRefreshWebData) forControlEvents:UIControlEventValueChanged];
    //开始加载数据时，即显示刷新图标
    [self.refreshControl beginRefreshing];
    

    
    //*--------------------------**/
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0 ,320 ,180)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    [headerView release],headerView = nil;

}
#pragma mark---请求网路数据---
-(void)_aquireWebDataWithParams:(NSDictionary *)paramDic{

    BJNewsRequest *request = [[BJNewsRequest alloc]init];
    request.delegate = self;
    [request startAcquireInfoWithParamsDictionary:paramDic];
    
}
#pragma mark---Refresh--
-(void)startRefreshWebData{
    
    self.isRefreshing = YES;
    
#pragma mark--同样可以实现清楚旧的刷新数据--
    

    //实例化参数字典
    NSMutableDictionary *pramasDic = [NSMutableDictionary dictionary];
    [pramasDic setObject:@"20131129" forKey:@"date"];
    [pramasDic setObject:@"1" forKey:@"startRecord"];
    [pramasDic setObject:@"10" forKey:@"len"];
    [pramasDic setObject:@"1234567890" forKey:@"udid"];
    [pramasDic setObject:@"Iphone" forKey:@"terminalType"];
    [pramasDic setObject:@"213" forKey:@"cid"];
    
    
    //调用初始化
    [self _aquireWebDataWithParams:pramasDic];



}


#pragma mark - BJNewsRequestDelegate-
-(void)request:(BJNewsRequest *)request didFinishLoadingWithInfo:(id)info{
    
    //请求数据完成后，给refreshControl结束刷新动画
    [self.refreshControl endRefreshing];
    

//    NSLog(@"%@",info);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *newList = [dic objectForKey:@"news"];
    //判断表示图的数据源是否存在若不存在，实例化它
    if (!self.newsListArray) {
        self.newsListArray = [NSMutableArray array];
    }
    
    if (self.isRefreshing) {
        [self.newsListArray removeAllObjects];//如果是正在刷新的话，就将数组中原有的旧数据移除
        self.isRefreshing = NO;
    }
    
    NSMutableArray *scrollDataArray = [NSMutableArray array];
   #warning 此处需网路请求数据，下载图片，待完善 
    //得到的newlist数组存储了一条新闻信息的字典，需要将每一个字典实例化为对应的BJNewsItem类的实例对象
    for (int i = 0; i < newList.count; i++) {

        BJNewsItem *newItem = [[BJNewsItem alloc] initWithDictionatry:[newList objectAtIndex:i]];
    
        if (i<3 && !self.headerScrollView) {
            [scrollDataArray addObject:newItem];
        }else{
            [self.newsListArray addObject:newItem];
        }
        [newItem release],newItem = nil;
        
    }
    
    
    if (!self.headerScrollView) {
        self.headerScrollView = [[BJHeaderScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 180) managerObjectsArray:scrollDataArray];
        [self.tableView.tableHeaderView addSubview:self.headerScrollView];
        
        
        [self.tableView.tableHeaderView addSubview:self.headerScrollView.newsTitleLabel];
        self.headerScrollView.delegate = self;
        self.headerScrollView.newsObjectsArray =scrollDataArray;
    }
    [self.tableView reloadData];
    

}
-(void)request:(BJNewsRequest *)request didFailedWithError:(NSError *)error{

    NSLog(@"%@",error);
    
}
#pragma mark========
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if ([scrollView isKindOfClass:[BJHeaderScrollView class]]) {
        BJHeaderScrollView *headerScrollView = (BJHeaderScrollView *)scrollView;
        NSInteger index = headerScrollView.contentOffset.x/320;
        BJNewsItem *showItem = [headerScrollView.newsObjectsArray objectAtIndex:index];
        headerScrollView.newsTitleLabel.text = showItem.newsTitle;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return (indexPath.row == self.newsListArray.count) ? 44 : 126;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //原始Cell加1 ，用于存放
    return self.newsListArray.count + 1;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.newsListArray.count) {
        
        //实例化参数字典
        NSMutableDictionary *pramasDic = [NSMutableDictionary dictionary];
        [pramasDic setObject:@"20131129" forKey:@"date"];
        
        NSString *startRecordString = [NSString stringWithFormat:@"%d",(20*self.pageIndex+1)];
        
        [pramasDic setObject:startRecordString forKey:@"startRecord"];
        [pramasDic setObject:@"10" forKey:@"len"];
        [pramasDic setObject:@"1234567890" forKey:@"udid"];
        [pramasDic setObject:@"Iphone" forKey:@"terminalType"];
        [pramasDic setObject:@"213" forKey:@"cid"];
        
        
        //调用初始化
        [self _aquireWebDataWithParams:pramasDic];
        self.pageIndex ++;
        
        BJActivityCell *activityCell = (BJActivityCell *)cell;
        [activityCell.activityIndicatorView startAnimating];
//        activityCell.activityIndicatorView.hidden = YES;
//        activityCell.loadingLabel.hidden = NO;
        
    }



}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row != self.newsListArray.count ) {
        
        static NSString *CellIdentifier = @"Cell";
        BJNewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[BJNewsItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
        }
        
        BJNewsItem *one = [self.newsListArray objectAtIndex:indexPath.row];
        cell.newTitleLabel.text = one.newsTitle;
        cell.newSummaryLabel.text = one.newsSummary;
        //设置summaryLabel不限制行数
        cell.newSummaryLabel.numberOfLines = 0;
        cell.newPublishDataLabel.text = [NSString stringWithFormat:@"发布于：%@",one.newsPublishDate];
        //通过使用第三方类库SDWebImageView完成指定图片链接的下载
        [cell.newAcatarImageView setImageWithURL:[NSURL URLWithString:one.newsPicURL]];
        
        return cell;
    }else{
    
        static NSString *cellActivity = @"Activity";
        BJActivityCell *activityCell = [tableView dequeueReusableCellWithIdentifier:cellActivity];
        if (activityCell == nil) {
            
            activityCell = [[[BJActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellActivity] autorelease];
//            activityCell.activityIndicatorView.hidden = YES;
//            activityCell.loadingLabel.hidden = YES;
#warning mark=-----待完善----------
            activityCell.hidden = YES;
        }
        return activityCell;
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
