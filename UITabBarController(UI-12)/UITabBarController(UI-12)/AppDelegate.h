//
//  AppDelegate.h
//  UITabBarController(UI-12)
//
//  Created by 范林松 on 14-2-27.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WeiboSDKDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;
@end