//
//  UIButton+ImageLabel.m
//  PinMoney
//
//  Created by mac on 16/9/10.
//  Copyright © 2016年 EdgarGuan. All rights reserved.
//

#import "UIButton+ImageLabel.h"

@implementation UIButton (ImageLabel)

+ (void)imageButtonWithLabel:(UIButton*)btn TitleEdge:(UIEdgeInsets)titleEdge ImgEdge:(UIEdgeInsets)imgEdge{
    //使图片和文字水平居中显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+18+titleEdge.top ,-btn.imageView.frame.size.width+titleEdge.left, 0.0+titleEdge.bottom, 0.0+titleEdge.right)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15+imgEdge.top, 0.0+imgEdge.left, 0.0+imgEdge.bottom, -btn.titleLabel.bounds.size.width+imgEdge.right)];
}

+ (void)imageButtonWithLabel:(UIButton*)btn{
    //使图片和文字水平居中显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+10 ,-btn.imageView.frame.size.width, 0.0,0.0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -btn.titleLabel.bounds.size.width)];
}

+ (void)ButtonWithRightImageLabelLeft:(UIButton*)btn{
    //使图片和文字水平居中显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-2*btn.imageView.frame.size.width, 0.0,0.0)];
//    //图片距离右边框距离减少图片的宽度，其它不边
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -btn.titleLabel.bounds.size.width)];
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.image.size.width, 0, btn.imageView.image.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
}

// 设置button的titleLabel和imageView的布局样式，及间距
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space isSizeToFit:(BOOL)isSizeToFit{
    
    if (isSizeToFit == YES) {
        [self sizeToFit];
        
    }
    // 得到imageView和titleLabel的宽、高
    
    CGFloat imageWidth  = 0.0;
    CGFloat imageHeight = 0.0;
    
    CGFloat labelWidth  = 0.0;
    CGFloat labelHeight = 0.0;
    
    if (self.currentImage) {
        imageWidth  = self.imageView.bounds.size.width;
        imageHeight = self.imageView.bounds.size.height;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth  = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth  = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
            break;
        case ButtonEdgeInsetsStyleLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            break;
        case ButtonEdgeInsetsStyleBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
            break;
        case ButtonEdgeInsetsStyleRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
            break;
        default:
            break;
    }
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    if (isSizeToFit == YES) {
        [self sizeToFit];
        
    }
}


@end
