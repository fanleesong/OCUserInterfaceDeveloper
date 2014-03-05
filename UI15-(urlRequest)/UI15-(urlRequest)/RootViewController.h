//
//  RootViewController.h
//  UI15-(urlRequest)
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<NSURLConnectionDataDelegate>

@property(nonatomic,retain) NSMutableData *receiveData;//暂存二进制数据


@end
