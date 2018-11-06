//
//  XTJSliderScrollView.m
//  轮播图
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import "XTJSliderScrollView.h"
#import "UIImageView+WebCache.h"
#import "XTJPageControl.h"

#define KPageColor RGB(50, 220, 160)
/** 滚动宽度*/
#define ScrollWidth self.frame.size.width
/** 滚动高度*/
#define ScrollHeight self.frame.size.height

#define pageSize 16

@interface XTJSliderScrollView ()<UIScrollViewDelegate>

@property (nonatomic, copy) NSArray *imageArray;

@end

@implementation XTJSliderScrollView
{
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak  UIScrollView *_scrollView;
    
    __weak  XTJPageControl *_PageControl;
    
    NSTimer *_timer;
    
    /** 当前显示的是第几个*/
    NSInteger _currentIndex;
    
    /** 图片个数*/
    NSInteger _MaxImageCount;
    
    /** 是否是网络图片*/
    BOOL _isNetworkImage;
}

#pragma mark - 本地图片

-(instancetype)initWithFrame:(CGRect)frame WithLocalImages:(NSArray *)imageArray
{
    if (imageArray.count < 2 ) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if ( self) {
        
        _isNetworkImage = NO;
        
        /** 创建滚动view*/
        [self createScrollView];
        
        /** 加入本地image*/
        [self setImageArray:imageArray];
        
        /** 设置数量*/
        [self setMaxImageCount:_imageArray.count];
    }
    
    return self;
}

#pragma mark - 网络图片
-(instancetype)initWithFrame:(CGRect)frame WithNetImages:(NSArray *)imageArray
{
    if (imageArray.count < 2 ) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if ( self) {
        
        _isNetworkImage = YES;
        
        /** 创建滚动view*/
        [self createScrollView];
        
        /** 加入本地image*/
        [self setImageArray:imageArray];
        
        /** 设置数量*/
        [self setMaxImageCount:_imageArray.count];
    }
    
    return self;
}

#pragma mark - 设置数量
-(void)setMaxImageCount:(NSInteger)MaxImageCount
{
    _MaxImageCount = MaxImageCount;
    
    /** 复用imageView初始化*/
    [self initImageView];
    
    /** pageControl*/
    [self createPageControl];
    
    /** 定时器*/
    [self setUpTimer];
    
    /** 初始化图片位置*/
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

#pragma mark - 加载ScrollView
- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    /** 复用，创建三个*/
    scrollView.contentSize = CGSizeMake(ScrollWidth * 3, 0);
    
    /** 设置滚动延时时间*/
    _autoScrollDelay = 0;
    
    /** 开始显示的是第一个   前一个是最后一个   后一个是第二张*/
    _currentIndex = 0;
    
    _scrollView = scrollView;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.8)];
    lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self addSubview:lineView];
}

-(void)setImageArray:(NSArray *)imageArray
{
    //如果是网络
    if (_isNetworkImage)
    {
        _imageArray = [imageArray copy];
        
    }else {
        //本地
        NSMutableArray *localimageArray = [NSMutableArray arrayWithCapacity:imageArray.count];
        for (NSString *imageName in imageArray) {
            [localimageArray addObject:[UIImage imageNamed:imageName]];
        }
        _imageArray = [localimageArray copy];
    }
}

- (void)initImageView {
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, ScrollHeight)];
    UIImageView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_SCREEN_WIDTH, 0, DEVICE_SCREEN_WIDTH, ScrollHeight)];
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_SCREEN_WIDTH * 2, 0, DEVICE_SCREEN_WIDTH, ScrollHeight)];
    
    centerImageView.userInteractionEnabled = YES;
    
    [centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:leftImageView];
    [_scrollView addSubview:centerImageView];
    [_scrollView addSubview:rightImageView];
    
    _leftImageView = leftImageView;
    _centerImageView = centerImageView;
    _rightImageView = rightImageView;
}

//点击事件
- (void)imageViewDidTap
{
    
    [self.netDelagate didSelectedNetImageAtIndex:_currentIndex];
    [self.localDelagate didSelectedLocalImageAtIndex:_currentIndex];
}

-(void)createPageControl
{
    XTJPageControl * pageControl = [[XTJPageControl alloc] initWithFrame:CGRectMake(0,ScrollHeight - pageSize - 10,ScrollWidth, 12)];
    
    //设置页面指示器的颜色
    //    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    //设置当前页面指示器的颜色
    pageControl.currentPageIndicatorTintColor = KPageColor;
    pageControl.numberOfPages = _MaxImageCount;
    pageControl.currentPage = 0;
    
    [self addSubview:pageControl];
    
    _PageControl = pageControl;
}

#pragma mark - 定时器

- (void)setUpTimer
{
    if (_autoScrollDelay < 0.5) return;
    
    _timer = [NSTimer timerWithTimeInterval:_autoScrollDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)scorll
{
    [_scrollView setContentOffset:CGPointMake(DEVICE_SCREEN_WIDTH +ScrollWidth, 0) animated:YES];
}

#pragma mark - 给复用的imageView赋值
- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    if (_isNetworkImage)
    {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[LeftIndex]] placeholderImage:self.placeholderImage options:SDWebImageRefreshCached];
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[centerIndex]] placeholderImage:self.placeholderImage options:SDWebImageRefreshCached];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[rightIndex]] placeholderImage:self.placeholderImage options:SDWebImageRefreshCached];
        
    }else
    {
        _leftImageView.image = _imageArray[LeftIndex];
        _centerImageView.image = _imageArray[centerIndex];
        _rightImageView.image = _imageArray[rightIndex];
    }
    
    [_scrollView setContentOffset:CGPointMake(ScrollWidth, 0)];
}

#pragma mark - 滚动代理

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)removeTimer
{
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //开始滚动，判断位置，然后替换复用的三张图
    [self changeImageWithOffset:scrollView.contentOffset.x];
}

- (void)changeImageWithOffset:(CGFloat)offsetX
{
    if (offsetX >= ScrollWidth * 2)
    {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1)
        {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxImageCount)
        {
            
            _currentIndex = 0;
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else
        {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        _PageControl.currentPage = _currentIndex;
        
    }
    
    if (offsetX <= 0)
    {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        _PageControl.currentPage = _currentIndex;
    }
}

-(void)dealloc
{
    [self removeTimer];
}

#pragma mark - set方法，设置间隔时间

- (void)setAutoScrollDelay:(NSTimeInterval)autoScrollDelay
{
    _autoScrollDelay = autoScrollDelay;
    
    [self removeTimer];
    [self setUpTimer];
}

- (UIImage *)placeholderImage{
    if (!_placeholderImage) {
        _placeholderImage = [[UIImage alloc] init];
    }
    return _placeholderImage;
}

@end

