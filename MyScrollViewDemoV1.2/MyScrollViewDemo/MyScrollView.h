//
//  MyScrollView.h
//  练习2
//
//  Created by lanou on 14-1-10.
//  Copyright (c) 2014年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    Right = 0, //循环向右播放
    Left  = 1  //循环向左播放
}playDirectionType;

@interface MyScrollView : UIView<UIScrollViewDelegate>

{
    UIScrollView    *_scrollView;       //滚动视图
    UIPageControl   *_pageControl;      //页面控制
    NSTimer         *_timer;            //自动播放定时器
    NSMutableSet    *_reusebledViews;   //可重用视图集合
}

/*-------------------------------------------------------
 *自动轮播的图片数组(存放图片路径)
 *------------------------------------------------------*/
@property (nonatomic, retain)NSArray *imagePaths;
/*-------------------------------------------------------
 *轮播图的播放时间间隔,在设置允许自动播放前设置,单位S
 *------------------------------------------------------*/
@property (nonatomic, assign)NSTimeInterval timerInterval;
/*-------------------------------------------------------
 *设置是否允许自动播放,默认不播放,在设置允许自动播放时,
 *如果没有设置播放时间间隔,默认是3S
 *------------------------------------------------------*/
@property (nonatomic, assign) BOOL autoRunEnable;
/*-------------------------------------------------------
 *pageControl采用lazyLoading模式,当设置pageControlEnabled为
 *YES时,生成一个pageControl,当设置NO时,销毁pageControl
 *------------------------------------------------------*/
@property (nonatomic, assign)BOOL pageControlEnabled;
//自动播放方向
@property (nonatomic, assign)playDirectionType playDirection;

//实现通过给定Bundel中的图片名称数组,给视图添加轮播图片的方法
-(void)setImagePathsInBundle:(NSArray *)imageNames;
//设置自动播放及轮播时间间隔
-(void)setAutoRunEnableWithInterval:(NSTimeInterval)time;

@end


//UIScrollView 类目
@interface UIScrollView (PageControl)

@property (nonatomic, assign)NSInteger currentPage;

-(NSInteger)numberOfPages;
-(void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;
-(void)autoChangePage;

@end
