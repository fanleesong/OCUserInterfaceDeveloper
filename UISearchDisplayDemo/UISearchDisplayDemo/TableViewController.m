//
//  TableViewController.m
//  UISearchDisplayDemo
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "TableViewController.h"
#import "DataUtils.h"

@interface TableViewController ()

@end

@implementation TableViewController

-(void)dealloc{
    
    [_colorListDictionary release];
    [_filterColorArray release];
    [_searchBar release];
    [_searchBarDisplay release];
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
    
    
    //调用
    [self _initColorSomeDataPropety];
    
}

//自定义实例化方法
-(void)_initColorSomeDataPropety{

    //获取文本信息
    self.colorListDictionary = [DataUtils parseData];
    NSLog(@"%@",self.colorListDictionary);
    
    //实例化searchBar
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)] autorelease];
    self.tableView.tableHeaderView = self.searchBar;
    
    //实例化searchDisplay
    self.searchBarDisplay = [[[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self] autorelease];
    
    self.searchBarDisplay.searchResultsDataSource = self;
//    self.searchBarDisplay.delegate = self;
    self.searchBarDisplay.searchResultsDelegate = self;
    
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
    // Return the number of rows in the section.
    if (tableView == self.tableView) {
        
       return [[self.colorListDictionary allKeys] count];

    }
    
    //TODO:获得搜索后返回的值
    //SELF contains[cd] %@---->包含某个字段
    //SELF beginsWith[cd] %@-------->以某个字段开头
    /*
     苹果提供的NSPredicate主要用于指定过滤器的条件，该对象可以准确的描述所需条件，对每个对象用谓词进行筛选，判断该对象是否与筛选条件一致
     用predicateWithFormat来创建一个用于搜索筛选信息的谓词
     self关键字，类似于方法调用中的self指针，表示当前被检索是否匹配的对象，constains[cd]是一个字符串运算符，contains表示包含的意思；而[cd]则表示不区分大小写，也不区分发音符号，还有另外两种形式--->[c]不区分大小写，[d]不区分发音符号。
     
     
     对于数组实例方法filterArrayUsingPredicate：则可以根据本身创建的谓词，循环检索数组中的每一个对象是否符合条件，一旦符合条件，该对象即被标示为YES，循环检索完成后，给方法会把所有标示为YES的对象存储在一个新的数组中作为返回值返回。
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",self.searchBar.text];
    
    NSArray *keyarray = [[self.colorListDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.filterColorArray = [keyarray filteredArrayUsingPredicate:predicate];
    
    
    return self.filterColorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    if (tableView == self.tableView) {
    
        //给字典排序
        NSArray *key = [[self.colorListDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
        //
        cell.textLabel.text = [key objectAtIndex:indexPath.row];
        //给cell上文字颜色赋值
        NSString *hexString = [self.colorListDictionary objectForKey:cell.textLabel.text];
        if ([hexString isEqualToString:@"FFFFFF"]) {
            cell.textLabel.textColor = [UIColor blackColor];
        }else{
            cell.textLabel.textColor = [self _generateColorObjectWithHex:hexString];
        }
        
        
    }else{
    
        
        cell.textLabel.text = [self.filterColorArray objectAtIndex:indexPath.row];
        //给cell上文字颜色赋值
        NSString *hexString = [self.colorListDictionary objectForKey:cell.textLabel.text];
        if ([hexString isEqualToString:@"FFFFFF"]) {
            cell.textLabel.textColor = [UIColor blackColor];
        }else{
            cell.textLabel.textColor = [self _generateColorObjectWithHex:hexString];
        }
    
    }
    
    
    
    return cell;
}

-(UIColor *)_generateColorObjectWithHex:(NSString *)hexString{


    unsigned int red,green,blue;
    NSRange range;
    range.location = 0;
    range.length = 2;
    //获取红色色值
    NSString *redString = [hexString substringWithRange:range];
    //实例化指定字符串的扫描器
    NSScanner *redScanner = [NSScanner scannerWithString:redString];
    [redScanner scanHexInt:&red];//将色值存入地址中
    
    range.location = 2;
    //获取绿色色值
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    //获取蓝色色值
    [[NSScanner scannerWithString:[hexString substringWithRange:range]] scanHexInt:&blue];
    
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];

    return color;
}

#pragma mark---------searchDa-----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *hexString = [self.colorListDictionary objectForKey:cell.textLabel.text];
    UIColor *color = [self _generateColorObjectWithHex:hexString];
    self.searchBar.barTintColor = cell.textLabel.textColor;
    self.navigationController.navigationBar.barTintColor = color;
    

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
