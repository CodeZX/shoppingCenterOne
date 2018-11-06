//
//  XTJSliderScrollView.h
//  轮播图
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderScrollViewNetDelegate <NSObject>

@optional

/** 点中网络滚动视图后触发*/
-(void)didSelectedNetImageAtIndex:(NSInteger)index;

@end

/** 遵循该代理就可以监控到本地滚动视图的index*/
@protocol JFSliderScrollViewLocalDelegate <NSObject>

@optional
/** 点中本地滚动视图后触发*/
-(void)didSelectedLocalImageAtIndex:(NSInteger)index;

@end

@interface XTJSliderScrollView : UIView
/** 选中网络图片的索引*/
@property (nonatomic, strong) id <SliderScrollViewNetDelegate> netDelagate;
/** 选中本地图片的索引*/
@property (nonatomic, strong) id <JFSliderScrollViewLocalDelegate> localDelagate;
/** 占位图*/
@property (nonatomic, strong) UIImage * placeholderImage;
/** 滚动延时*/
@property (nonatomic, assign) NSTimeInterval autoScrollDelay;


/**
 本地图片
 @param frame 位置
 @param imageArray 本地
 */
- (instancetype) initWithFrame:(CGRect)frame WithLocalImages:(NSArray *)imageArray;


/**
 加载网络图片
 @param frame 位置大小
 @param imageArray 名字
 */
- (instancetype) initWithFrame:(CGRect)frame WithNetImages:(NSArray *)imageArray;


@end

