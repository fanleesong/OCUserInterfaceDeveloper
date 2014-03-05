//
//  ThemeManager.h
//  WeiCo
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject


@property(nonatomic,retain)NSString *themName;//当前使用的主题
@property(nonatomic,retain)NSMutableArray *themePlist;
+(ThemeManager *)sharedInstance;
@end
