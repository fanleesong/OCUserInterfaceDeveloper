//
//  BJNewsRequest.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJNewsRequest.h"

//延展方法
@interface BJNewsRequest()

@property (nonatomic,retain)NSMutableData *receiveData;//存储网络数据

//将字典转化为制定格式的字符串
-(NSString *)_parseDictinaryToFormatedString:(NSDictionary *)dic;

@end
/*
 
 http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?
 date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213
 
 */
@implementation BJNewsRequest

-(NSString *)_parseDictinaryToFormatedString:(NSDictionary *)dic{

    NSMutableArray *typeArray = [NSMutableArray array];
    NSArray *keysArray = [dic allKeys];
    for (NSString *key in keysArray) {
        
        NSString *valueString = [dic objectForKey: key];
        NSString *formatString = [NSString stringWithFormat:@"%@=%@",key,valueString];
        [typeArray addObject:formatString];
        
    }
    //通过调用componentsJoinedByString:方法可以将数组的每一个子字符串中间拼接&得到最终格式的字符串 EG:key1=value1&key2=value2
    NSString *finalString = [typeArray componentsJoinedByString:@"&"];
    return finalString;
    
}

-(void)startAcquireInfoWithParamsDictionary:(NSDictionary *)paramDic{

    
    NSString *paramString = [self _parseDictinaryToFormatedString:paramDic];
    //异步post请求
    NSString *urlString = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [request setHTTPMethod:@"POST"];
    //设置POST请求方式
    [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    //根据链接请求建立链接，并设置委托对象，开始传输数据
    [NSURLConnection connectionWithRequest:request delegate:self];
    


}
#pragma mark-NSURConnectionDataDelegate-
//连接请求得到服务器响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    self.receiveData = [NSMutableData data];
    
}
//开始下载数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [self.receiveData appendData:data];

}
//下载数据完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSString *jsonString = [[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    //使用协议方法传递下载完成的jsonString给被委托方
    if (self.delegate && [self.delegate respondsToSelector:@selector(request:didFinishLoadingWithInfo:)]) {
    
        [self.delegate request:self didFinishLoadingWithInfo:self.receiveData];
        
    }
//    [jsonString release],jsonString = nil;
    
}
//链接请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    //直接传递错误信息
    if (self.delegate && [self.delegate respondsToSelector:@selector(request:didFailedWithError:)]) {
        [self.delegate request:self didFailedWithError:error];
    }
    
}


-(void)dealloc{
    [_receiveData release];
    [super dealloc];
}












@end
