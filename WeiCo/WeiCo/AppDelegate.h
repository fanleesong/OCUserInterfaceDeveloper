//
//  AppDelegate.h
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SinaWeibo;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property(retain,nonatomic)SinaWeibo *sinaweibo;
@property(retain,nonatomic)MainViewController *mainCtrl;

@end
