//
//  MainViewController.m
//  contantDemo
//
//  Created by 范林松 on 14-2-17.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "MainViewController.h"
#import "ContactItem.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //涉及到视图加载添加的部分不建议使用在该部分操作数据
        //由于会打乱视图的声明周期
        
         self.contactLListArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.contactLListArray = [NSMutableArray array];
    //
    self.contactTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.contactTableView.rowHeight = 50;
    //        self.contactTableView.separatorColor = [UIColor redColor];
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    
   
     [self.view addSubview:self.contactTableView];
    
    self.title = @"通讯录";
    
    ContactItem *user01 = [[ContactItem alloc] init];
    user01.contactName =@"张薇";
    user01.contactPhoneNumber = @"13978231289";
    user01.contactAvatarImage = [UIImage imageNamed: @"avatar.png"];
    
    [self.contactLListArray addObject:user01];
    
    
}
#pragma mark==============实现TableViewDatasource必选方法=================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//标示图有多少行，取决于对应数组数据源数组中有多少对象
    return [self.contactLListArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *codeID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:codeID];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:codeID] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    ContactItem *one = [self.contactLListArray objectAtIndex:indexPath.row];
    
    //设置Cell内容
    cell.textLabel.text =one.contactName;
    cell.detailTextLabel.text = one.contactPhoneNumber;
    cell.imageView.image = one.contactAvatarImage;
    
    
    return cell;
}
//响应点击右边详情按钮事件
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //获取点击事件的属性值
    ContactItem *contaxt = [self.contactLListArray objectAtIndex:indexPath.row];
    
    DetailViewController *details = [[DetailViewController alloc] init];
    //传值
    details.contactItem = contaxt;
    details.indexPath = indexPath;
    details.delegate = self;//接收自定义协议
    
    [self.navigationController pushViewController:details animated:YES];
    [details release];

}
//实现自定义代理的方法
-(void)didEditContactInfo:(ContactItem *)item atIndexPath:(NSIndexPath *)indexPath{

    //替换数据源中对一个数据的数据，及时更新
    [self.contactLListArray replaceObjectAtIndex:indexPath.row withObject:item];
    //数据更新结束后，刷新界面
    [self.contactTableView reloadData];
    
    
}

-(void)dealloc{
    [_contactTableView release];
    [_contactLListArray release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
