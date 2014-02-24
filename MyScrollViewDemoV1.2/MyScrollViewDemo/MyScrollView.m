//
//  MyScrollView.m
//  练习2
//
//  Created by lanou on 14-1-10.
//  Copyright (c) 2014年 蓝鸥科技. All rights reserved.
//

#import "MyScrollView.h"

#define TAGOFFSET 1000

//UIScrollView类目
@implementation UIScrollView (PageControl)

-(NSInteger)numberOfPages
{
    NSInteger pageNumber = self.contentSize.width / self.bounds.size.width;
    return pageNumber;
}

-(NSInteger)currentPage
{
    NSInteger currentPage = floor((self.contentOffset.x - self.frame.size.width/2) /self.frame.size.width) + 1;
    return currentPage;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage animated:NO];
}

-(void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated
{
    //计算x偏移量
    CGFloat offsetX = self.bounds.size.width * currentPage;
    //生成offset
    CGPoint offset = CGPointMake(offsetX, 0);
    [self setContentOffset:offset animated:animated];
}

-(void)autoChangePage
{
    if (![self isDecelerating] && ![self isDragging])
    {
        if (self.currentPage == [self numberOfPages]-1)
        {
            self.currentPage = 1;
        }
        NSInteger cPage = self.currentPage+1;
        [self setCurrentPage:cPage animated:YES];
    }
    
    [self performSelector:@selector(autoChangePage) withObject:nil afterDelay:3];
}

@end


#pragma mark - MyScrollView 类实现
//类延展
@interface MyScrollView ()

//定时器关联自动播放方法
-(void)autoChangePicture:(NSTimer *)timer;

@end

@implementation MyScrollView

- (void)dealloc
{
    [_imagePaths release],     _imagePaths     = nil;
    [_scrollView release],     _scrollView     = nil;
    [_pageControl release],    _pageControl    = nil;
    [_reusebledViews release], _reusebledViews = nil;
    [super dealloc];
}
/*---------------------------------------
 *指派初始化方法
 *--------------------------------------*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //----------------1.初始化ScrollView-------------------------
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.pagingEnabled = YES;
        //隐藏水平滚动指示器
        _scrollView.showsHorizontalScrollIndicator = NO;
        //初始滚动大小为0
        _scrollView.contentSize = CGSizeZero;
        [self addSubview:_scrollView];
        
        //设置滚动视图的代理
        _scrollView.delegate = self;
        
        //-----------------2.初始化定时器定时间隔,默认3S------------------
        _timerInterval = 3.0f;
        
        //-----------------3.创建可重用视图集合
        _reusebledViews = [[NSMutableSet alloc] init];
    }
    return self;
}

/*----------------------------------------------------------------
 *pageControl的ValueChanged关联的方法,改变滚动视图的当前页面
 *---------------------------------------------------------------*/
-(void)pageControlChangePicture:(UIPageControl *)pageControl
{
    _scrollView.currentPage = pageControl.currentPage + 1;
}


/*----------------------------------------------------------------
 *重写pageControlEnabled的setter方法,实现pageControl的lazyLoading
 *---------------------------------------------------------------*/
- (void)setPageControlEnabled:(BOOL)pageControlEnabled
{
    if (_pageControlEnabled != pageControlEnabled)
    {
        _pageControlEnabled = pageControlEnabled;
        
        //使能pageControl时加载
        if (_pageControlEnabled == YES)
        {
            //----------------初始化pageControl--------------------------
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
            //设置页面指示器的颜色
            _pageControl.pageIndicatorTintColor = [UIColor grayColor];
            //设置当前页面指示器的颜色
            _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
            
            [_pageControl addTarget:self action:@selector(pageControlChangePicture:) forControlEvents:UIControlEventValueChanged];
            //设置页码数量
            [_pageControl setNumberOfPages:[_imagePaths count]];
            [self addSubview:_pageControl];
            
        }
        else//禁用时释放
        {
            [_pageControl removeFromSuperview];
            [_pageControl release], _pageControl = nil;
        }

    }
}

/*-------------------------------------------------------------------------
 *重写fram的setter方法,当改变view的fram时,scrollView和pageControl的fram跟着变动
 *------------------------------------------------------------------------*/
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    //设置滚动视图和页面控制视图的fram
    _scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    //如果设置了pageControl,也调整pageControl的fram
    if (_pageControlEnabled == YES)
    {
        _pageControl.frame = CGRectMake(0, frame.size.height-20, frame.size.width, 20);
    }
}


/*-------------------------------------------------------------------------
 *方法原型:-> - (void)setImagePathsInBundle:(NSArray *)imageNames;
 *方法功能:-> 实现通过给定Bundel中的图片名称数组,给视图添加轮播图片的方法
 *入口参数:-> (NSArray *)imageNames,在Bundle中的图片名数组
 *出口参数:-> 无
 *------------------------------------------------------------------------*/
- (void)setImagePathsInBundle:(NSArray *)imageNames
{
    //创建imagePaths数组
    NSMutableArray *imagePaths = [NSMutableArray array];
    for (NSString *imageName in imageNames)
    {
        //获得文件路径
        NSString *imagePath = [self getResourcePath:imageName];
        //把文件路径添加到文件路径数组中
        [imagePaths addObject:imagePath];
    }
    //设置轮播图片文件路径
    [self setImagePaths:imagePaths];
    
}


/*-------------------------------------------------------------------------
 *方法原型:-> - (NSString *)getResourcePath:(NSString *)resourceName;
 *方法功能:-> 接收一个在Bundle中的图片名,返回图片路径.
 *入口参数:-> (NSString *)resourceName,在Bundle中的图片名称
 *出口参数:-> (NSString *),图片的路径
 *------------------------------------------------------------------------*/
- (NSString *)getResourcePath:(NSString *)resourceName
{
    //将图片名称分割成数组
    NSArray *names = [resourceName componentsSeparatedByString:@"."];
    //获取文件扩展名
    NSString *lastName = [names lastObject];
    //获取文件扩展名的长度
    NSInteger lastNameLength = [lastName length];
    //计算主文件名长度
    NSInteger firstNameLength = resourceName.length - lastNameLength - 1;
    //获取主文件名
    NSString *firstName = [resourceName substringToIndex:firstNameLength];
    //获取资源路径
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:firstName ofType:lastName];
    
    return [[sourcePath retain] autorelease];
}

/*---------------------------------------------------
 *ImagePaths属性的setter方法,该方法内实现scrollView
 *要轮播图片内容的设置和pageControl的属性设置
 *--------------------------------------------------*/
-(void)setImagePaths:(NSArray *)imagePaths
{
    if (_imagePaths != imagePaths && [imagePaths count] != 0)
    {
        [_imagePaths release];
        _imagePaths = [imagePaths retain];
        
        //移除scrollView上所有的imageView对象
        for (id view in _scrollView.subviews)
        {
            if ([view isKindOfClass:[UIImageView class]] == YES)
            {
                [view removeFromSuperview];
            }
        }
        //图片张数大于1时轮番显示
        if ([_imagePaths count] > 1)
        {
            //--------根据图片数组详细设置scrollView的属性-------------
            _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*([_imagePaths count] + 2), 0);
            
            CGRect rect = _scrollView.bounds;
            for (int i = 0; i < 3; i++)
            {
                rect.origin.x = _scrollView.bounds.size.width * i;
                UIImageView *imageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
                
                //照片索引
                NSInteger imageIndex = i;
                //首页放最后一张照片
                if (imageIndex == 0)
                {
                    imageIndex = [_imagePaths count] - 1;
                }
                else
                {
                    imageIndex = i - 1;
                }
                
                imageView.image = [UIImage imageWithContentsOfFile:[_imagePaths objectAtIndex:imageIndex]];
                imageView.tag = TAGOFFSET + i;
                
                [_scrollView addSubview:imageView];
            }
            //初始页码为1
            [_scrollView setTag:1];
            //显示第1页
            [_scrollView setCurrentPage:1];

        }
        else//就一张照片
        {
            _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, 0);
            UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
            imageView.image = [UIImage imageWithContentsOfFile:[_imagePaths objectAtIndex:0]];
            [_scrollView addSubview:imageView];

        }
        
        //把滚动视图追加到视图上
        [self addSubview:_scrollView];
        //设置自己为代理
        [_scrollView setDelegate:self];
        //设置按页滚动
        [_scrollView setPagingEnabled:YES];
        
        //-----------------根据图片数组详细设置scrollView的属性-------------------
        //如果设置了pageControl,则显示第一页
        if (_pageControlEnabled == YES)
        {
            [_pageControl setNumberOfPages:[_imagePaths count]];
        }
        
    }//endif(_imagePaths != imagePaths)
    
}


/*---------------------------------------------------
 *autoRunEnable属性的setter方法,该方法实现开启自动播放
 *和禁止自动播放功能
 *--------------------------------------------------*/
-(void)setAutoRunEnable:(BOOL)autoRunEnable
{
    if (_autoRunEnable != autoRunEnable)
    {
        _autoRunEnable = autoRunEnable;
        
        if (autoRunEnable == YES)//开启自动轮播
        {
            [self setAutoRunEnableWithInterval:_timerInterval];
        }
        else //禁止自动播放
        {
            //销毁定时器,并置指针为空
            [_timer invalidate];
            _timer = nil;
        }

    }
}


/*-------------------------------------------------------
 *轮播时间间隔(timerInterval)属性的setter方法,该方法实现在更新
 *了时间间隔时,重新开启新的的定时器的功能.
 *------------------------------------------------------*/
- (void)setTimerInterval:(NSTimeInterval)timerInterval
{
    //如果是新的时间间隔则更新
    if (_timerInterval != timerInterval)
    {
        _timerInterval = timerInterval;
        
        //如果已经设置了自动播放,则重新设置定时器
        if (_autoRunEnable == YES)
        {
            [self setAutoRunEnableWithInterval:timerInterval];
        }

    }
}


/*-------------------------------------------------------
 *实现使能自动播放,并设置自动播放时间间隔
 *------------------------------------------------------*/
-(void)setAutoRunEnableWithInterval:(NSTimeInterval)time
{
    if (time > 0.0f)
    {
        _autoRunEnable = YES;
        //更新定时时间间隔
        _timerInterval = time;
        //先把原来的定时器关掉
        [_timer invalidate];
        //开启新的定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(autoChangePicture:) userInfo:nil repeats:YES];
    }
    else
    {
        _autoRunEnable = NO;
        [_timer invalidate];
        _timer = nil;
    }
    
}

/*-------------------------------------------------------
 *定时器关联自动播放方法,检测到页面在滚动或者用户在点击时,重新开启
 *新的定时器.根据设定的播放方向轮番播放
 *------------------------------------------------------*/
-(void)autoChangePicture:(NSTimer *)timer
{
    if ([_imagePaths count] == 1)
    {
        return;
    }
    
    //读取当前页码
    NSInteger currentPage = [_scrollView currentPage];
    //定义下一页页面变量
    NSInteger nextPage = 0;
    //判断播放方向
    switch (_playDirection)
    {
        //往右轮播
        case Right:
             nextPage = currentPage + 1;
             break;
            
            //往左轮播
        case Left:
             nextPage = currentPage - 1;
             break;
    }
    
    //切换到下一页
    [_scrollView setCurrentPage:nextPage animated:YES];
    
}


#pragma mark - ScrollView 代理方法
//将要拖动时调用,用来关闭自动播放的定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //销毁定时器,暂停自动播放
    [_timer invalidate];
    _timer = nil;
}
//停止减速时调用,用来重启定时器
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //重新开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timerInterval target:self selector:@selector(autoChangePicture:) userInfo:nil repeats:YES];
}

//scrollView滚动时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算新页码,往高处取整
    int pageNumber = ceil(_scrollView.contentOffset.x  / _scrollView.frame.size.width - 0.5);
    
    /*---------------------------------------------------------------------------
     *实现循环滚动,当滚动到当滚动到最后一页时(放的是首张照片),把滚动视图的显示区域切换到第一页
     *--------------------------------------------------------------------------*/
    if (scrollView.contentOffset.x >= ([_imagePaths count] + 1) * scrollView.bounds.size.width)
    {
        //把可重用的倒数第3页,放到第1页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:([_imagePaths count] - 1) andThePageNumberWillBePlaced:1];
        
        //把可重用的倒数第1页,放到第2页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:([_imagePaths count] + 1) andThePageNumberWillBePlaced:2];
        
        //把可重用的倒数第2页,放到第0页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:[_imagePaths count] andThePageNumberWillBePlaced:0];
        
        //把页面切换到第一页
        [scrollView setTag:1];
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        
        return;
    }
    /*--------------------------------------------------------------------------------
     *实现循环滚动,当滚动到当滚动到第0页时(放的是最后一张照片),把滚动视图的显示区域切换到倒数第二页
     *-------------------------------------------------------------------------------*/
    else if (scrollView.contentOffset.x <= 0.0f) //滚动到首页,要翻到最后
    {
        
        
        //把可重用的第2页,放到倒数第2页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:2 andThePageNumberWillBePlaced:[_imagePaths count]];
        
        //把可重用的第1页,放到倒数第1页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:1 andThePageNumberWillBePlaced:([_imagePaths count] + 1)];
        
        //把可重用的第0页,放到倒数第3页(页码排序是:0 1 2 3 ...3 2 1)
        [self thePageNumberReuseabled:0 andThePageNumberWillBePlaced:([_imagePaths count] - 1)];
        
        //把页面切换到倒数第二页
        [scrollView setTag:[_imagePaths count]];
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * [_imagePaths count], 0);
        
        return;
    }
    
    /*---------------------------------------------------------------
     *当往右翻页时,并且不是最后一页时实现把当前不在可见范围的视图放进可重用集合,
     *然后从集合里取可重用的视图,放上对应的图片,放在当前页码的下一页上.
     *--------------------------------------------------------------*/
    if (pageNumber > scrollView.tag && pageNumber != ([_imagePaths count] + 1))//往右翻页
    {
        [scrollView setTag:pageNumber];
        NSLog(@"%d",pageNumber);
        
        [self thePageNumberReuseabled:(pageNumber - 2) andThePageNumberWillBePlaced:(pageNumber + 1)];
    }
    /*-------------------------------------------------------------
     *当往左翻页时,并且不是第0页时实现把当前不在可见范围的视图放进可重用集合,
     *然后从集合里取可重用的视图,放上对应的图片,放在当前页码的上一页上.
     *------------------------------------------------------------*/
    else if(pageNumber < scrollView.tag && pageNumber != 0)
    {
        [scrollView setTag:pageNumber];
        NSLog(@"%d",pageNumber);
        
        [self thePageNumberReuseabled:(pageNumber + 2) andThePageNumberWillBePlaced:(pageNumber - 1)];
    }
    
    //-------------------如果使能了pageControl,则需要进行页面调整--------------------------
    if (_pageControlEnabled == YES)
    {
        if (pageNumber == 0)
        {
            _pageControl.currentPage = [_imagePaths count];
        }
        else if(pageNumber == 1 || pageNumber == [_imagePaths count]+1)
        {
            _pageControl.currentPage = 0;
        }
        else
        {
            _pageControl.currentPage = pageNumber - 1;
        }

    }
}


/*------------------------------------------------------------------------------
 *方法原型:-> - (void)thePageNumberReuseabled:(NSInteger)srcPageNumber 
               andThePageNumberWillBePlaced:(NSInteger)destPageNumber;
 *方法功能:-> 实现把指定页码的可重用视图放进可重用集合里,并从可重用视图集合里取一个
             视图放到要重用的页码上,并加载上对应的图片.
 *入口参数:-> (NSInteger)srcPageNumber,不在可视范围内的图片页码,要放入可重用集合里的页码.
             (NSInteger)destPageNumber,将要显示的页码,即从可重用集合里取视图放在该页面上.
 *出口参数:-> 无
 *------------------------------------------------------------------------------*/
- (void)thePageNumberReuseabled:(NSInteger)srcPageNumber andThePageNumberWillBePlaced:(NSInteger)destPageNumber
{
    //--实现把指定页码的可重用视图放进可重用集合
    UIImageView *reusebledView = (UIImageView *)[_scrollView viewWithTag:(TAGOFFSET + srcPageNumber)];
    //把当前不显示的View放进可重用集合里
    if (reusebledView != nil)
    {
        [_reusebledViews addObject:reusebledView];
    }
    
    //--从可重用视图集合里取一个视图放到指定的页码上,并加载上对应的图片
    UIImageView *rView = [_reusebledViews anyObject];
    //如果没有可以重用的View
    if (rView == nil)
    {
        rView = [[[UIImageView alloc] init] autorelease];
        [_scrollView addSubview:rView];
    }
    else
    {   //如果找到了可重用的View,把它移出可重用集合
        [_reusebledViews removeObject:rView];
    }
    //为view设置tag值,供下次通过它查找其他view的计算服务
    [rView setTag:TAGOFFSET + destPageNumber];
    CGRect rect = _scrollView.bounds;
    //为View计算新的fram
    rect.origin.x = rect.size.width * destPageNumber;
    rView.frame = rect;
    //为View找图片索引
    NSInteger imageIndex;
    if (destPageNumber == 0)//首页放最后一张照片
    {
        imageIndex = [_imagePaths count] - 1;
    }
    else if(destPageNumber == [_imagePaths count] + 1)//最后一页放首张照片
    {
        imageIndex = 0;
    }
    else
    {
        imageIndex = destPageNumber - 1;
    }
    //为view获得对应的图片路径
    NSString *imagePath = [_imagePaths objectAtIndex:imageIndex];
    //设置对应的图片
    rView.image = [UIImage imageWithContentsOfFile:imagePath];
}


@end
