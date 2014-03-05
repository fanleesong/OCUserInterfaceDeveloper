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
#import "BJNewsItem.h"

@interface BJNewsViewController ()<NewsRequestDelegate,UIScrollViewDelegate>

@property(nonatomic,retain) NSMutableArray *newsListArray;//提供数据源数组
@property (nonatomic,retain) BJHeaderScrollView *headerScrollView;

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
    /*
     date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213
     */

    //实例化参数字典
    NSMutableDictionary *pramasDic = [NSMutableDictionary dictionary];
    [pramasDic setObject:@"20131129" forKey:@"date"];
    [pramasDic setObject:@"1" forKey:@"startRecord"];
    [pramasDic setObject:@"8" forKey:@"len"];
    [pramasDic setObject:@"1234567890" forKey:@"udid"];
    [pramasDic setObject:@"Iphone" forKey:@"terminalType"];
    [pramasDic setObject:@"213" forKey:@"cid"];

    BJNewsRequest *request = [[BJNewsRequest alloc]init];
    request.delegate = self;
    [request startAcquireInfoWithParamsDictionary:pramasDic];
    
    
    //*--------------------------**/
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0 ,320 ,180)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    [headerView release],headerView = nil;

}

#pragma mark - BJNewsRequestDelegate-
-(void)request:(BJNewsRequest *)request didFinishLoadingWithInfo:(id)info{

//    NSLog(@"%@",info);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *newList = [dic objectForKey:@"news"];
    //判断表示图的数据源是否存在若不存在，实例化它
    if (!self.newsListArray) {
        self.newsListArray = [NSMutableArray array];
    }
    
    NSMutableArray *scrollDataArray = [NSMutableArray array];
    
   #warning 此处需网路请求数据，下载图片，待完善 
    //得到的newlist数组存储了一条新闻信息的字典，需要将每一个字典实例化为对应的BJNewsItem类的实例对象
    for (int i = 0; i < newList.count; i++) {

        BJNewsItem *newItem = [[BJNewsItem alloc] initWithDictionatry:[newList objectAtIndex:i]];
    
        if (i<3) {
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

    return 126;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
