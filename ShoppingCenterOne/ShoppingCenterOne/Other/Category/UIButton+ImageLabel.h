//
//  UIButton+ImageLabel.h
//  PinMoney
//
//  Created by mac on 16/9/10.
//  Copyright © 2016年 EdgarGuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonEdgeInsetsStyle) {
    
    ButtonEdgeInsetsStyleTop,    // image在上，title在下
    ButtonEdgeInsetsStyleLeft,   // image在左，title在右
    ButtonEdgeInsetsStyleBottom, // image在下，title在上
    ButtonEdgeInsetsStyleRight   // image在右，title在左
};

@interface UIButton (ImageLabel)

/**
 设置button的titleLabel和imageView的布局样式，及间距
 
 @param style titleLabel和imageView的布局样式
 @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space isSizeToFit:(BOOL)isSizeToFit;


+ (void)imageButtonWithLabel:(UIButton*)btn;

+ (void)ButtonWithRightImageLabelLeft:(UIButton*)btn;

+ (void)imageButtonWithLabel:(UIButton*)btn TitleEdge:(UIEdgeInsets)titleEdge ImgEdge:(UIEdgeInsets)imgEdge;

@end
