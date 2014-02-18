//
//  HomeViewController.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "HomeViewController.h"
#import "UserInfo.h"
#import "UserInfo2.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (NSMutableArray *)hardCode{
    UserInfo *u1 = [UserInfo userInfoWithName:@"robin" phoneNumber:@"1" imagePath:nil];
    UserInfo2 *u2 = [UserInfo2 userInfo2WithName:@"zoro" email:@"2@lanou3g.com" imagePath:nil];
    UserInfo *u3 = [UserInfo userInfoWithName:@"sogeking" phoneNumber:@"3" imagePath:nil];
    UserInfo2 *u4 = [UserInfo2 userInfo2WithName:@"luffy" email:@"4@lanou3g.com" imagePath:nil];
    UserInfo *u5 = [UserInfo userInfoWithName:@"nami" phoneNumber:@"5" imagePath:nil];
    UserInfo2 *u6 = [UserInfo2 userInfo2WithName:@"sanji" email:@"6@lanou3g.com" imagePath:nil];
    UserInfo *u7 = [UserInfo userInfoWithName:@"chopper" phoneNumber:@"7" imagePath:nil];
    UserInfo2 *u8 = [UserInfo2 userInfo2WithName:@"frank" email:@"8@lanou3g.com" imagePath:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:u1, u2, u4, u6, u7, u8, nil];
    
    int i = 1;
    for (UserInfo *userInfo in array) {
        NSString *imageName = [NSString stringWithFormat:@"h%d", i++];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpeg"];
        [userInfo setImagePath:imagePath];
    }
    
    return [[array retain] autorelease];
   
}

@end
