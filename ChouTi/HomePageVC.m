//
//  HomePageVC.m
//  DemoProject
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "HomePageVC.h"
#import "MainCell.h"
#import "Status.h"
#import "NewsViewAssistVC.h"
#import "NormalCommentAssistVC.h"
#import "NetImageDataManager.h"
static NSString * fontType = @"YES";

#define TextViewPadding            16.0
#define LineBreakMode              UILineBreakModeWordWrap
#define IMAGE_HEIGHT 80.0f

@implementation HomePageVC
@synthesize upView;
@synthesize statusArr;
@synthesize subjectType;

- (void)setRefreshView{
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView* view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0-self.tableView.bounds.size.height, self.tableView.frame.size.width, self.view.bounds.size.height)];
        view1.delegate=self;
        [self.tableView addSubview:view1];
        _refreshHeaderView=view1;
        [view1 release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setRefreshView];
    
    manager = [HTTPMessageManager getInstance];
    notificationCenter = [NSNotificationCenter defaultCenter];
    imageDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
       
    if(subjectType == Hot){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotHotHomePageInfo object:nil];
        [manager getHotHomePageInfo];
    }else if(subjectType == News){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotNewsHomePageInfo object:nil];
        [manager getNewsHomePageInfo];
    }else if(subjectType == Scoff){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotScoffHomePageInfo object:nil];
        [manager getScoffHomePageInfo];
    }else if(subjectType == Tec){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotTecHomePageInfo object:nil];
        [manager getTecHomePageInfo];
    }else if(subjectType == Pic){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotPicHomePageInfo object:nil];
        [manager getPicHomePageInfo];
    }else if(subjectType == Ask){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHomePageInfo:) name:GotAskHomePageInfo object:nil];
        [manager getAskHomePageInfo];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeType:) name:CHANGEFONTTYPE object:nil];
   

    [notificationCenter addObserver:self selector:@selector(didGetImages:) name:NETIMAGEDATA_NOTIFICATION object:nil];
}

- (void)viewDidUnload
{
    [notificationCenter removeObserver:self];
    self.statusArr = nil;
    manager = nil;
    imageDictionary = nil;
    [LoadView release];
    LoadView = nil;
    [self setUpView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
   // self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:YES];
}

- (void)dealloc{
    if(statusArr){
        [statusArr release];
    }
    [manager release];
    [imageDictionary release];
    [LoadView release];
    [upView release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [statusArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCellIdentifier";
    MainCell *cell = (MainCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MainCell" owner:self options:nil];
        cell = [nibObjects objectAtIndex:0];
    }
    
    if ([fontType isEqualToString:@"YES"]) {
        cell.content.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:15];
        cell.submittedTime.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:15];
        cell.userName.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:15];
        }
    else{
        cell.content.font = [UIFont  systemFontOfSize:15];    
        cell.submittedTime.font = [UIFont  systemFontOfSize:15];
        cell.userName.font =  [UIFont  systemFontOfSize:15];
    }
    
    if(indexPath.row > [statusArr count] || [statusArr count] == 0 || [statusArr isEqual:[NSNull null]]){
        return cell;
    }
    Status *status = [statusArr objectAtIndex:indexPath.row];
    NSData *imageData = [imageDictionary objectForKey:[NSNumber numberWithInt:indexPath.row]];
    cell.index = indexPath.row;
    cell.delegate = self;
    [cell setUpCell:status withSubjectType:subjectType andImage:imageData];
    return cell;
}

#pragma mark - SetHeightForCell

- (CGFloat)setHeightForCell:(NSString*)text with:(CGFloat)with{
    UIFont * font=[UIFont systemFontOfSize:17];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(with - TextViewPadding, MAXFLOAT) lineBreakMode:LineBreakMode];
    CGFloat height;
    if(size.height < IMAGE_HEIGHT - 10){
        height = IMAGE_HEIGHT + 75;
    }else{
        height = size.height + 65;
    }
    return height;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= 3){
        CGRect frame = upView.frame;
        frame.origin.x = 280;
        frame.origin.y = 400;
        upView.frame = frame;
        [self.tableView addSubview:upView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row > [statusArr count] || [statusArr count] == 0 || [statusArr isEqual:[NSNull null]]){
        return 0;
    }
    NSString *text;
    Status *status = [statusArr objectAtIndex:indexPath.row];
    if(subjectType == Hot){
        NSString *type;
        if(status.subjectType != Rumour){
            if(status.subjectType == News){
                type = @"42区";
            }else if(status.subjectType == Scoff){
                type = @"段子";
            }else if(status.subjectType == Tec){
                type = @"挨踢1024";
            }else if(status.subjectType == Pic){
                type = @"图片";
            }else if(status.subjectType == Ask){
                type = @"你问我答";
            }
            text = [NSString stringWithFormat:@"%@ (%@)",status.title, type];
        }else{
            text = [NSString stringWithFormat:@"【谣言】  %@", status.title];
        }
    }else{
        text = status.title;
    }
    CGFloat height = [self setHeightForCell:text with:240.0f];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status *status = [statusArr objectAtIndex:indexPath.row];
    if(![status.contentUrl isEqual:[NSNull null]] && status.contentUrl.length != 0){
        NewsViewAssistVC *assistView = [[NewsViewAssistVC alloc]initWithNibName:@"NewsViewAssistVC" bundle:nil];
        assistView.hidesBottomBarWhenPushed = YES;
        assistView.delegate = self;
        assistView.title = status.summitedUser.nickName;
        assistView.url = status.contentUrl;
        assistView.index = indexPath.row;
        [self.navigationController pushViewController:assistView animated:YES];
        [assistView release];
    }else{
        [self pushCommentsView:indexPath.row];
    }
}

#pragma mark - pushCommentView

- (void)pushCommentsView:(NSInteger)index{
    if(index < 0 || index >= [statusArr count]){
        return;
    }
    Status *status = [statusArr objectAtIndex:index];
    NormalCommentAssistVC *assistView = [[NormalCommentAssistVC alloc]initWithNibName:@"NormalCommentAssistVC" bundle:nil];
    assistView.hidesBottomBarWhenPushed = YES;
    assistView.status = status;
    [self.navigationController pushViewController:assistView animated:YES];
    [assistView release];
}

#pragma mark - GetMessage

- (void)didGetHomePageInfo:(NSNotification*)sender{
    self.statusArr = sender.object;
    [self.tableView reloadData];
    [LoadView removeFromSuperview];
    [imageDictionary removeAllObjects];
    [self getImages];
}

- (void)getImages{
    for(int i = 0; i < [statusArr count]; i++){
        Status *aStatus = [statusArr objectAtIndex:i];
        // 空字符串到底应该怎样判断？？？？？
        // 获取图片
        if(![aStatus.imageUrl isEqual:[NSNull null]] && aStatus.imageUrl.length != 0){
            [[NetImageDataManager getInstance]getDataWithUrl:aStatus.imageUrl withIndex:i];
        }        
    }
}

- (void)didGetImages:(NSNotification*)sender{
    NSDictionary *imageInfo = sender.object;
    NSString *url = [imageInfo objectForKey:IMAGEDATA_URL];
    NSString *data = [imageInfo objectForKey:IMAGEDATA];
    NSNumber *indexNumber = [imageInfo objectForKey:IMAGEDATA_INDEX];
    NSInteger index = [indexNumber intValue];
    if(index < 0 || index > [statusArr count]){
        return;
    }
    if(index >= [statusArr count]){
        return;
    }
    Status *status = [statusArr objectAtIndex:index];
    // 将图片添加到字典里
    if([url isEqualToString:status.imageUrl]){
        [imageDictionary setObject:data forKey:indexNumber];
    }
    // 单行刷新
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *arr = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:NO];
}

- (IBAction)toTop:(id)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - RefreshTableViewData

- (void)reloadTableViewDataSource
{
    NSLog(@"==开始加载数据");
    _reloading=YES;
    //加载数据的操作在这个方法里实现
    if(subjectType == Hot){
        [manager getHotHomePageInfo];
    }else if(subjectType == News){
        [manager getNewsHomePageInfo];
    }else if(subjectType == Scoff){
        [manager getScoffHomePageInfo];
    }else if(subjectType == Tec){
        [manager getTecHomePageInfo];
    }else if(subjectType == Pic){
        [manager getPicHomePageInfo];
    }else if(subjectType == Ask){
        [manager getAskHomePageInfo];
    }
}
- (void)doneLoadingTableViewData
{
    NSLog(@"==加载完数据");
    _reloading=NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollView did scroll========");
    NSLog(@"===========scrollView height %f", scrollView.frame.size.height);
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}
-(void)changeType:(NSNotification *)sender{
    fontType = sender.object;
    if ([fontType isEqualToString:@"YES"]) {
        
        [self.tableView reloadData];
    }
    else{
        [self.tableView reloadData];
    }
}


@end
