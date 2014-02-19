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
    //添加数组元素
    ContactItem *user01 = [[ContactItem alloc] init];
    user01.contactName =@"张薇";
    user01.contactPhoneNumber = @"13978231289";
    user01.contactAvatarImage = [UIImage imageNamed: @"avatar.png"];
    [self.contactLListArray addObject:user01];
    
    
    
    
    //设置单元格的视图
    self.title = @"通讯录";
    self.contactTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.contactTableView.rowHeight = 50;
    //当对单元格进行操作时改变其编辑状态
//    self.contactTableView.editing= YES;
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    
    [self.view addSubview:self.contactTableView];
    //初始化导航栏添加按钮
    UIBarButtonItem *addContactBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddContactAction:)];
    self.navigationItem.rightBarButtonItem = addContactBarItem;
    [addContactBarItem release],addContactBarItem = nil;
    
    
}

#pragma mark==============实现TableViewDatasource必选方法=================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"%s",__FUNCTION__);
    //标示图有多少行，取决于对应数组数据源数组中有多少对象
    return [self.contactLListArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%s",__FUNCTION__);
    
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

//实现代理方法---单元格编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSLog(@"%s",__FUNCTION__);
    
    return YES;
}
//指定单元格被编辑的具体样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //指定单元格可被编辑的操作类型为
     NSLog(@"%s",__FUNCTION__);
    return UITableViewCellEditingStyleDelete;
    
}
//提交编辑数据的按钮类型
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除指定对象
    
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (int i = 0; i<self.contactLListArray.count; i++) {
        NSInteger sectionNumber = 0;
        NSInteger rowNumber = i;
        NSIndexPath *oneIndexPath = [NSIndexPath indexPathForRow:rowNumber inSection:sectionNumber];
        [indexPathArray addObject:oneIndexPath];
    }
    //删除数组中对象
    [self.contactLListArray removeAllObjects];
    
    
    //删除指定行->每执行一次删除单元格 就会主动刷新界面
    //每次界面刷新都会调用被委托方对象中实现的两个协议方法
    //1.tableView:numberOfRowsInSection:
    //2.tableView:cellForRowAtIndexPath:
    //因此 一定要保证数据源数组中的对象数目跟tableView行数一致，否则就会出现删除操作错误，App奔溃

    //    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationLeft];
    
    
    
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


#pragma mark===============自定义================
//实现自定义代理的方法
-(void)didEditContactInfo:(ContactItem *)item atIndexPath:(NSIndexPath *)indexPath{
    
    if (item == nil) {
        [self.contactLListArray removeObjectAtIndex:indexPath.row];
    }
    else{
        //替换数据源中对一个数据的数据，及时更新
        [self.contactLListArray replaceObjectAtIndex:indexPath.row withObject:item];
    }
    
    //数据更新结束后，刷新界面
    [self.contactTableView reloadData];
    
    
}

//实现点击后添加联系人方法
-(void)handleAddContactAction:(UIBarButtonItem *)sender{

    //设置系统自定义视图UIAlertView
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加联系人" message:@"您将要添加一个新的联系人\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    //设置弹出框样式
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;//密码框
//    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;//单框
    
    //修改自带的文本域占位信息
//    [alertView textFieldAtIndex:0].placeholder = @"联系人姓名";

//    [alertView textFieldAtIndex:1].placeholder = @"联系人电话";
//    [alertView textFieldAtIndex:1].secureTextEntry = NO;
    alertView.alertViewStyle = UIAlertViewStyleDefault;//只有按钮
    
    //发送显示show消息，让弹出框显示
    [alertView show];
    [alertView release],alertView = nil;
    

}

#pragma mark========UIAlertView弹出框的必选代理方法==============
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //如果点击的是确定按钮时
    if (buttonIndex == 1) {
        //获取弹出框中文本框输入的信息
        UITextField *names = [alertView textFieldAtIndex:0];
        UITextField *mobile= [alertView textFieldAtIndex:1];
        
        //赋值
        ContactItem *oneitem = [[ContactItem alloc]init];
        oneitem.contactName = names.text;
        oneitem.contactPhoneNumber =mobile.text;
//        oneitem.contactName = @"hihii";
//        oneitem.contactPhoneNumber =@"jijiji";
        oneitem.contactAvatarImage = [UIImage imageNamed:@"avatar.png"];
        
        [self.contactLListArray addObject:oneitem];
        [oneitem release],oneitem = nil;
        //刷新视图数据,数组中的数据有更新
        [self.contactTableView reloadData];
        
    }else{
        return;
    }
    
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
//- (void)alertViewCancel:(UIAlertView *)alertView{
//
//}
////实现将要显示AlertView弹出框之前系统将要调用的方法
//- (void)willPresentAlertView:(UIAlertView *)alertView{
//    //修改自带的文本域占位信息
////    [alertView textFieldAtIndex:0].placeholder = @"联系人姓名";
//
////    [alertView textFieldAtIndex:1].placeholder = @"联系人电话";
////    [alertView textFieldAtIndex:1].secureTextEntry = NO;
//    
//
//}
//// before animation and showing view
//- (void)didPresentAlertView:(UIAlertView *)alertView{
//
////    [alertView textFieldAtIndex:1].placeholder = @"联系人电话";
////    [alertView textFieldAtIndex:1].secureTextEntry = NO;
//    
//}
//// after animation
//
//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
//
//
//}
//// before animation and hiding view
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//
//}
//// after animation
//
//// Called after edits in any of the default fields added by the style
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
//
//    return  YES;
//}
//




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
