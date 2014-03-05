//
//  BJNewsRequest.h
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJNewsRequest;

@protocol NewsRequestDelegate <NSObject>

-(void)request:(BJNewsRequest *)request didFinishLoadingWithInfo:(id)info;
-(void)request:(BJNewsRequest *)request didFailedWithError:(NSError *)error;

@end


@interface BJNewsRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,assign)id<NewsRequestDelegate> delegate;

//根据POST请求参数字典，开始建立请求，下载数据
-(void)startAcquireInfoWithParamsDictionary:(NSDictionary *)paramDic;


@end
