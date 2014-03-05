//
//  RootViewController.m
//  UI15-(urlRequest)
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "JSON.h"
#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
-(void)dealloc{
    [_receiveData release];
    [super dealloc];
}
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
    //调用同步或异步get请求方式
    [self _GetinitSynchronousRequestAndAySynchronousRequest];
    
    
    //异步post请求
//    [self _PostinitSynchronousRequestAndAySynchronousRequest];
    
    
//    [self _JSONAnaliys];
    
    
}

#pragma mark-json解析-
-(void)_JSONAnaliys{

    NSDictionary *jsonSerial=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"students" ofType:@"json"] ] options:NSJSONReadingMutableContainers error:nil];

    NSLog(@"%@",[[[jsonSerial objectForKey:@"students"] objectAtIndex:0] objectForKey:@"name"]);
    
/*
 //1.获取JSON文件
 NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"students" ofType:@"json"]encoding:NSUTF8StringEncoding error:nil];
 //2.实例化JSON解析器
 NSDictionary *jsonSerial = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

 */

}

#pragma mark----同步或异步post请求方式-----
-(void)_PostinitSynchronousRequestAndAySynchronousRequest{

    
    NSString *urlString = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *posts = [NSMutableURLRequest requestWithURL:url];
    //为可变请求变量设置为POST形式
    [posts setHTTPMethod:@"POST"];
    //将请求所需的参数作为请求体在建立连接时发送给服务器
    NSString *bodyString = @"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    NSData *bodydata = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //为请求添加请求体
    [posts setHTTPBody:bodydata];
    //根据请求建立连接
    [NSURLConnection connectionWithRequest:posts delegate:self];
    
    
    
    //同步post请求
//    NSData *datas = [NSURLConnection  sendSynchronousRequest:posts returningResponse:nil error:nil];

}

#pragma mark----同步或异步get请求方式-----
-(void)_GetinitSynchronousRequestAndAySynchronousRequest{

    //异步get请求
    NSString *urlString = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    //实例化url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //实例化NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //建立网络连接
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    //同步get请求
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dics = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",[[[dics objectForKey:@"news"] objectAtIndex:0] objectForKey:@"summary"]);
    


}


#pragma mark-NSURLConnectionDelegate-
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    //一旦建立连接的服务器正确响应了，会由委托方connection对象，回调这个协议方法，告诉被委托方连接成功
    NSLog(@"%s",__FUNCTION__);


}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    NSLog(@"%s",__FUNCTION__);
    //连接地址建立成功后，就开始进行数据传输，传输的数据是多个分段传输的，所以该协议方法会多次调用，知道数据传输完成
    if (!self.receiveData) {
        self.receiveData = [NSMutableData data];
    }
    [self.receiveData appendData:data];

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSLog(@"%s",__FUNCTION__);
    //数据传输完成
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",[[[dic objectForKey:@"news"] objectAtIndex:0] objectForKey:@"summary"]);
//    NSLog(@"%@",dic);

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
