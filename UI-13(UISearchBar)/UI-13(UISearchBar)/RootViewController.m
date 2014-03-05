//
//  RootViewController.m
//  UI-13(UISearchBar)
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //实例化一个UISearchBar对象，并并通过属性配置searchbar
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 44)];
    
    
    
    //-----配置外观部分----------------------
    //1.设置bartintColor属性设置searchbar颜色
    search.barTintColor = [UIColor orangeColor];
    //2.通过设置scopeButtonTitle属性可以显示一个对应的segmentContrl，用来在搜索中提供分类，达到快速搜索目的
    search.scopeButtonTitles = @[@"收件人",@"主题",@"发件人"];
    //3.发送消息，让视图显示scopeButtonTitle
    search.showsScopeBar = NO;
    //4.给searchBar发送sizeToFit消息，更新segment的frame
    [search sizeToFit];
    //5.显示取消按钮
    search.showsCancelButton = NO;
    //6.显示书签按钮
    search.showsBookmarkButton = NO;
    //7.显示promt
    search.prompt = @"正在查询";
    //8.更改placeholder
    search.placeholder = @"请输入邮箱";
    //每一次涉及到变换时需要调用sizeToFit来更新对应的SearchBar的frame
    [search sizeToFit];
    //接收searchbar协议
    search.delegate = self;
    
    
    //-------------------------------------
    [self.view addSubview:search];
    [search release],search = nil;
    
}

#pragma mark ------Searchbar Delegate--------

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    //已经开始编辑了
//    searchBar.showsCancelButton  = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    searchBar.showsScopeBar = YES;
    [searchBar sizeToFit];
    
    
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    //点击取消时
    [searchBar resignFirstResponder];
    //取消编辑并隐藏
    searchBar.showsCancelButton  = NO;
    searchBar.showsScopeBar = NO;
    [searchBar sizeToFit];

}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{

    NSString *scopestring = [searchBar.scopeButtonTitles objectAtIndex:selectedScope];
    NSLog(@"搜索条件之一%@",scopestring);

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    //键盘上的search按钮被点击时会响应的协议方法
    //1。得到搜索栏中的文本
    NSString *searchTextString = searchBar.text;
    //2.得到segmented中的搜索条件
    NSString *scopeString = [searchBar.scopeButtonTitles objectAtIndex:searchBar.selectedScopeButtonIndex];
    NSLog(@"搜索条件：%@-----%@",searchTextString,scopeString);
    //3.searchBar 取消编辑状态
    [searchBar resignFirstResponder];

}















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
