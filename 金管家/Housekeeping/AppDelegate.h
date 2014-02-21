//
//  AppDelegate.h
//  Housekeeping
//
//  Created by user on 13-3-28.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class WelcomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;
@property (strong, nonatomic)WelcomeViewController*welcomeViewController;
@property (strong, nonatomic)UINavigationController *navigationController;

@end
