//
//  NormalCommentAssistVC.m
//  DemoProject
//
//  Created by administrator on 13-11-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NormalCommentAssistVC.h"
#import "CommentCell.h"
#import "Comment.h"
#import "NetImageDataManager.h"
#import "TwitterVC.h"
#import "OAuthWebView.h"

#define TextViewPadding            16.0
#define LineBreakMode              UILineBreakModeWordWrap
#define IMAGE_HEIGHT 80.0f
#define IMAGE_WIDTH 70.0f

@implementation NormalCommentAssistVC
@synthesize myTableView;
@synthesize myCommentTV;
@synthesize upCount;
@synthesize headerView;
@synthesize headerBackImage;
@synthesize contentTV;
@synthesize contentImage;
@synthesize refreshButton;
@synthesize status;
@synthesize ids;
@synthesize commentsArr;
@synthesize headDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setHeadView{
    self.contentTV.text = status.title;
    [refreshButton setTitle:[NSString stringWithFormat:@"%@ 评论",status.commentsCount] forState:UIControlStateNormal];
    //    self.timeLabel
    
    // setHeight
    [contentTV layoutIfNeeded];
    CGRect frame = contentTV.frame;
    frame.size = contentTV.contentSize;
    contentTV.frame = frame; 
    
    frame = contentImage.frame;
    frame.origin.x = contentTV.frame.origin.x + contentTV.frame.size.width + 5;
    frame.size.height = IMAGE_HEIGHT;
    frame.size.width = IMAGE_WIDTH;
    contentImage.frame = frame;
    
    frame = refreshButton.frame;
    if(contentTV.frame.size.height < IMAGE_HEIGHT){
        frame.origin.y = contentImage.frame.origin.y + IMAGE_HEIGHT + 5;
    }else{
        frame.origin.y = contentTV.frame.origin.y + contentTV.frame.size.height + 5;
    }
    refreshButton.frame = frame;
    
    frame = headerView.frame;
    frame.size.height = refreshButton.frame.origin.y + refreshButton.frame.size.height + 20;
    headerView.frame = frame;
    
    headerBackImage.frame = headerView.frame; 
    headerBackImage.image = [[UIImage imageNamed:@"table_header_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    isUp = status.hasUped;
    isSave = status.hasSaved;
    upCount.text = [NSString stringWithFormat:@"%@",status.upsCount];
    manager = [HTTPMessageManager getInstance];
    headDictionary = [[NSMutableDictionary alloc]init];
    [self setHeadView];
    [self.myTableView setTableHeaderView:headerView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetImage:) name:NETHEAD_IMAGEDATA_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetCommentIds:) name:GotCommentlistIds object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetCommentList:) name:GotCommentList object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetHeadImages:) name:NETIMAGEDATA_NOTIFICATION object:nil];
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setMyCommentTV:nil];
    [self setUpCount:nil];
    [self setHeaderView:nil];
    [self setHeaderBackImage:nil];
    [self setContentTV:nil];
    [self setContentImage:nil];
    [self setRefreshButton:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getImage];
    [manager getCommentList:status.statusId];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [myTableView release];
    [myCommentTV release];
    [upCount release];
    [headerView release];
    [headerBackImage release];
    [contentTV release];
    [contentImage release];
    [refreshButton release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCellIdentifier";
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
        cell = [nibObjects objectAtIndex:0];
    }
    if(indexPath.row > commentsArr.count){
        return cell;
    }
    NSData *headImage = [headDictionary objectForKey:[NSNumber numberWithInt:indexPath.row]];
    Comment *comment = [commentsArr objectAtIndex:indexPath.row];
    [cell setUpCell:comment withData:headImage andStatusId:status.statusId];
    return cell;
}

#pragma mark - setHeightForCell

- (CGFloat)setHeightForCell:(NSString*)text with:(CGFloat)with{
    UIFont * font=[UIFont systemFontOfSize:14];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(with - TextViewPadding, 300000.0f) lineBreakMode:LineBreakMode];
    if(size.height < IMAGE_HEIGHT){
        size.height = IMAGE_HEIGHT + 10;
    }
    CGFloat height = size.height + 40;
    return height;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row > commentsArr.count){
        return 1;
    }
    Comment *comment = [commentsArr objectAtIndex:indexPath.row];
    CGFloat height = [self setHeightForCell:comment.content with:320.0f];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - HTTPMethods

- (void)didGetCommentIds:(NSNotification*)sender{
    self.ids = sender.object;
    [refreshButton setTitle:[NSString stringWithFormat:@"%d 评论",[ids count]] forState:UIControlStateNormal];
    NSMutableArray *idArr = [[NSMutableArray alloc]initWithCapacity:0];
    for(id item in ids){
        [idArr addObject:[NSString stringWithFormat:@"%@", item]];
    }
    [manager getRealComments:idArr];
}

- (void)didGetCommentList:(NSNotification*)sender{
    self.commentsArr = sender.object;
    if([commentsArr count] == 0){
        return;
    }
    [self.myTableView reloadData];
    // 获取头像
    [self getHeadImages];
}

- (void)getHeadImages{
    for(int i = 0; i < [commentsArr count]; i++){
        Comment *comment  = [commentsArr objectAtIndex:i];
        NSLog(@"commentUserurl ==========%@",comment.summitedUser.imageURL);
        if(![comment.summitedUser.imageURL isEqual:[NSNull null]] && comment.summitedUser.imageURL.length != 0){
            [[NetImageDataManager getInstance]getDataWithUrl:comment.summitedUser.imageURL withIndex:i];
        }
    }
}

- (void)didGetHeadImages:(NSNotification*)sender{
    NSDictionary *imageInfo = sender.object;
    NSString *url = [imageInfo objectForKey:IMAGEDATA_URL];
    NSData *data = [imageInfo objectForKey:IMAGEDATA];
    NSNumber *indexNumber = [imageInfo objectForKey:IMAGEDATA_INDEX];
    NSInteger index = [indexNumber intValue];
    if(index < 0 || index > [commentsArr count]){
        return;
    }
    if(index >= [commentsArr count]){
        return;
    }
    // 将头像图片添加到字典里
    Comment *comment = [commentsArr objectAtIndex:index];
    if([url isEqualToString:comment.summitedUser.imageURL]){
        [headDictionary setObject:data forKey:indexNumber];
    }
    // 单行刷新
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *arr = [NSArray arrayWithObject:indexPath];
    [self.myTableView reloadRowsAtIndexPaths:arr withRowAnimation:NO];
}

// 获得信息图片

- (void)getImage{
    if(![status.imageUrl isEqual:[NSNull null]] && status.imageUrl.length != 0){
        [[NetImageDataManager getInstance]getDataWithUrl:status.imageUrl withIndex:-1];
    }else{
        self.contentImage.image = [UIImage imageNamed:@"loadingImage_50x118.png"];
    }
}

- (void)didGetImage:(NSNotification*)sender{
    NSDictionary *imageInfo = sender.object;
    NSString *url = [imageInfo objectForKey:IMAGEDATA_URL];
    NSData *data = [imageInfo objectForKey:IMAGEDATA];
    if([url isEqualToString:status.imageUrl]){
        self.contentImage.image = [UIImage imageWithData:data];
    }else{
        self.contentImage.image = [UIImage imageNamed:@"loadingImage_50x118.png"];
    }
}

#pragma mark - bottomMethods

- (IBAction)isUp:(id)sender{
    if(!isUp){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostUpMessage:) name:PostUpMessage object:nil];
        [manager postUpMessage:status.statusId];
        isUp = YES;
    }else{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostCancelUpMessage:) name:PostCancelUpMessage object:nil];
        [manager postCancelUpMessage:status.statusId];
        isUp = NO;
    }
}

- (void)didPostUpMessage:(NSNotification*)sender{
    NSNumber *ups = sender.object;
    upCount.text = [NSString stringWithFormat:@"%@",ups];
}

- (void)didPostCancelUpMessage:(NSNotification*)sender{
    NSNumber *ups = sender.object;
    upCount.text = [NSString stringWithFormat:@"%@",ups];
}

- (IBAction)isSave:(id)sender{
    if(!isSave){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostSaveMessage:) name:PostSaveMessage object:nil];
        [manager postSaveMessage:status.statusId];
        isSave = YES;
    }else{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostCancelSaveMessage:) name:PostCancelSaveMessage object:nil];
        [manager postCancelSaveMessage:status.statusId];
        isSave = NO;
    }
}

- (void)didPostSaveMessage:(NSNotification*)sender{
    NSNumber *saveId = sender.object;
    if(saveId != nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"收藏成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}

- (void)didPostCancelSaveMessage:(NSNotification*)sender{
    NSNumber *saveId = sender.object;
    if(saveId != nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"取消收藏成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}

- (IBAction)shareTo:(id)sender {
    TwitterVC * twitter = [[TwitterVC alloc]initWithNibName:@"TwitterVC" bundle:nil];
    [self.navigationController pushViewController:twitter animated:YES];
    [twitter release];
}

- (IBAction)refreshCommentsList:(id)sender {
    [manager getCommentList:status.statusId];
}



@end
