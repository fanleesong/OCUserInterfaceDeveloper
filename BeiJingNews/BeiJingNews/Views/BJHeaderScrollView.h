//
//  BJHeaderScrollView.h
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJHeaderScrollView : UIScrollView

@property (nonatomic,retain) UILabel *newsTitleLabel;
@property (nonatomic,retain) NSArray *newsObjectsArray;

//自定义初始化方法，方法的第二个参数是用来传递scrollView所要展示的三条新闻数据信息的对象
-(id)initWithFrame:(CGRect)frame managerObjectsArray:(NSArray *)objectsArray;

@end
