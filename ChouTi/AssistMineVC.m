//
//  AssistMineVC.m
//  ChouTi
//
//  Created by administrator on 13-11-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AssistMineVC.h"
#import "MainCell.h"
#import "MyCommentCell.h"
#import "NewsViewAssistVC.h"
#import "NormalCommentAssistVC.h"
#import "Status.h"

@implementation AssistMineVC
@synthesize infoType;
@synthesize arr;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [HTTPMessageManager getInstance];
    imageDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetMyList:) name:GotMySaveList object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetMyList:) name:GotMyPublishList object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetMyList:) name:GotMyRecommentList object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetMyList:) name:GotMyCommentsList object:nil];
    if(infoType == save){
        self.navigationItem.title = @"私藏";
        [manager getMySavedList];
    }else if(infoType == publish){
        self.navigationItem.title = @"发布";
        [manager getMyPublishList];
    }else if(infoType == recommend){
        self.navigationItem.title = @"推荐";
        [manager getMyRecommendList];
    }else if(infoType == comment){
        self.navigationItem.title = @"评论";
        [manager getMyCommentsList];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if(infoType != comment){
        CellIdentifier = @"MainCellIdentifier";
        
        MainCell *cell = (MainCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MainCell" owner:self options:nil];
            cell = [nibObjects objectAtIndex:0];
        }
        if(indexPath.row > [arr count] || [arr count] == 0 || [arr isEqual:[NSNull null]]){
            return cell;
        }
        Status *status = [arr objectAtIndex:indexPath.row];
        NSData *imageData = [imageDictionary objectForKey:[NSNumber numberWithInt:indexPath.row]];
        cell.index = indexPath.row;
        [cell setUpCell:status withSubjectType:status.subjectType andImage:imageData];
        return cell;
    }else{
        CellIdentifier = @"MyCommentCellIdentifier";
        
        MyCommentCell *cell = (MyCommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MyCommentCell" owner:self options:nil];
            cell = [nibObjects objectAtIndex:0];
        }
        if(indexPath.row > [arr count] || [arr count] == 0 || [arr isEqual:[NSNull null]]){
            return cell;
        }
        MyComment *myComment = [arr objectAtIndex:indexPath.row];
        [cell setUpMyCommentCell:myComment];
        return cell;
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row > [arr count] || [arr count] == 0 || [arr isEqual:[NSNull null]]){
        return 0;
    }
    NSString *text;
    if(infoType != comment){
        Status *status = [arr objectAtIndex:indexPath.row];
        text = status.title;
    }else{
        MyComment *comment = [arr objectAtIndex:indexPath.row];
        text = comment.content;
    }
    CGFloat height = [self setHeightForCell:text with:240.0f];
    return height;
}

- (void)pushComments:(NSInteger)index{
    Status *status = [arr objectAtIndex:index];
    NormalCommentAssistVC *assistView = [[NormalCommentAssistVC alloc]initWithNibName:@"NormalCommentAssistVC" bundle:nil];
    assistView.hidesBottomBarWhenPushed = YES;
    assistView.status = status;
    [self.navigationController pushViewController:assistView animated:YES];
    [assistView release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(infoType != comment){
        Status *status = [arr objectAtIndex:indexPath.row];
        if(![status.contentUrl isEqual:[NSNull null]] && status.contentUrl.length != 0){
            NewsViewAssistVC *assistView = [[NewsViewAssistVC alloc]initWithNibName:@"NewsViewAssistVC" bundle:nil];
            assistView.hidesBottomBarWhenPushed = YES;
            assistView.dele = self;
            assistView.title = status.summitedUser.nickName;
            assistView.url = status.contentUrl;
            assistView.index = indexPath.row;
            [self.navigationController pushViewController:assistView animated:YES];
            [assistView release];
        }else{
            [self pushCommentsView:indexPath.row];
        }
    }else{
    }
}

#pragma mark - methods

- (void)didGetMyList:(NSNotification*)sender{
    self.arr = sender.object;
    [self.tableView reloadData];
}

@end
