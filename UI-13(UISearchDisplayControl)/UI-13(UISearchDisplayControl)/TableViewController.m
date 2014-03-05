//
//  TableViewController.m
//  UI-13(UISearchDisplayControl)
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

//搜索条件后的文件
@property(nonatomic,retain)NSMutableArray *filterArray;

@end

@implementation TableViewController

-(void)dealloc{
    [_listArray release];
    [_searchBar release];
    [_searchDisplay release];
    [_filterArray release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //-------------------------------------
    self.listArray = [NSMutableArray array];
    [self.listArray addObject:@"东方不败"];
    [self.listArray addObject:@"岳不群"];
    [self.listArray addObject:@"独孤求败"];
    [self.listArray addObject:@"令狐冲"];
    
    
    //__________________________________
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    self.tableView.tableHeaderView = self.searchBar;//设置到标示图的头部
    
    //TODO:______________UISearchDisplayController___________________
    //TODO:UISearchDisplayController本身是直接继承与NSObject类的，既不是视图控制器，也不是视图，但是要用来控制searchBar以及用searchBar来搜索对应信息，所以在实例化时要为其制定两个对象，一个是searchBar，一个是用于搜索的视图控制器
    self.searchDisplay = [[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self] autorelease];
    //搜索的结果列表为返回值，所涉及的tableviewDelegate和tableviewDatasource俩个协议
    self.searchDisplay.searchResultsDataSource = self;
    self.searchDisplay.searchResultsDelegate = self;
    self.searchDisplay.delegate = self;
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//TODO:待完善
    if (tableView == self.tableView) {
        //如果是当前视图的
        return self.listArray.count;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",self.searchBar.text];
    //赋值
    self.filterArray = (NSMutableArray *)[self.listArray filteredArrayUsingPredicate:predicate];
    
    //否则显示结果视图
    return self.filterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    if (tableView == self.tableView) {
        //如果是本视图
        cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
        
    }else{
        //如果是搜索后的结果视图
        cell.textLabel.text = [self.filterArray objectAtIndex:indexPath.row];
    
    }
    
    return cell;
}

#pragma mark-UISearchDisplayDelegate-
-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{

    NSLog(@"%s",__FUNCTION__);

}
-(void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView{


    NSLog(@"%s",__FUNCTION__);
    
}
-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{

    NSLog(@"%s",__FUNCTION__);
    
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
