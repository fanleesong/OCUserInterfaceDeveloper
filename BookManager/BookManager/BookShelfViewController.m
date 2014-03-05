//
//  BookShelfViewController.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookShelfViewController.h"
#import "BookShelf.h"
#import "BookTypeViewController.h"
#import "BookDetailViewController.h"
#import "AddBooksViewController.h"
#import "TrashViewController.h"
#import "BookDao.h"

@interface BookShelfViewController ()

@property(nonatomic ,retain)NSMutableArray *booksArray;

@end

@implementation BookShelfViewController

-(void)dealloc{

    [_booksArray release];
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
    
    self.navigationItem.leftBarButtonItem =[[[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(typeAction:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddBookAction:)] autorelease];
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.title = @"书架";
    
    //查询所有图书状态为1，即未在回收站中或未删除的
    self.booksArray = [BookDao findBookByStatus:1];
    [self.tableView reloadData];
    
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"书架",@"回收站"]];
    seg.tag = 100;
    seg.selectedSegmentIndex = 0;
    seg.frame = CGRectMake(0, 430, self.view.bounds.size.width, 50);
    [seg addTarget:self action:@selector(handleSegAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    [seg release],seg = nil;
    
    
    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark-handleSegAction-
-(void)handleSegAction:(UISegmentedControl *)sender{

    if (sender.selectedSegmentIndex == 0) {
        
        //查询所有图书状态为1，即未在回收站中或未删除的
        self.booksArray = [BookDao findBookByStatus:1];
        [self.tableView reloadData];
        
        
    }else{
        sender.selectedSegmentIndex = 0;
        
        TrashViewController *trash = [[TrashViewController alloc] init];
        //查询状态为0的书籍
        trash.booksArray = [BookDao findBookByStatus:0];
        
        [self.navigationController pushViewController:trash animated:YES];
        
        [trash.tableView reloadData];
        [trash release],trash = nil;
    }


}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    UISegmentedControl *segment = (UISegmentedControl *)[self.view viewWithTag:100];
    
    if (segment.selectedSegmentIndex == 0) {
        
//        //查询所有图书状态为1，即未在回收站中或未删除的
//        self.booksArray = [BookDao findBookByStatus:1];
//        [self.tableView reloadData];
        
    }
    
    
    NSLog(@"%s",__FUNCTION__);


}


//实现查看分类的方法
-(void)typeAction:(UIBarButtonItem *)sender{

    BookTypeViewController *typeVC = [[BookTypeViewController alloc] init];
    [self.navigationController pushViewController:typeVC animated:YES];
    [typeVC release],typeVC = nil;
    

}
//
-(void)AddBookAction:(UIBarButtonItem *)sender{
    
    AddBooksViewController *addVC = [[AddBooksViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];


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
    return self.booksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BookShelf *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[BookShelf alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    Books *bookinfo = [self.booksArray objectAtIndex:indexPath.row];
    cell.bookNameLabel.text = bookinfo.bookName;
    cell.bookCoverImage.image = [UIImage imageNamed:@"hihi.png"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f",bookinfo.bookPrice];
    cell.typeLabel.text = bookinfo.typeName;
    
    
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //得到该对象
        Books *getBook = [self.booksArray objectAtIndex:indexPath.row];
        getBook.isDelete = 0;
        
        //当点击删除时，就会该改变其状态为isDelete=0
        [BookDao updateBookById:getBook];
        NSLog(@"jijijiji =%d",getBook.isDelete);
        
        self.booksArray = [BookDao findBookByStatus:1];
        [self.booksArray removeObjectAtIndex:indexPath.row];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
//实现点击单行显示每本书籍具体信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //接收数据
    Books *getBook = [self.booksArray objectAtIndex:indexPath.row];
    //实例化视图对象并传递值
    BookDetailViewController *detailVC = [[BookDetailViewController alloc] init];
    detailVC.books = getBook;
    //推出新场景
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [getBook release],getBook = nil;
    [detailVC release],detailVC = nil;
    

}


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
