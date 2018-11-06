//
//  UIButton+XTJCreate.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "UIButton+XTJCreate.h"

@implementation UIButton (XTJCreate)
+ (UIButton *)XTJ_createWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    
    return [self XTJ_createWithTitle:title titleColor:[UIColor blackColor] font:14 selectTitle:nil imageName:imageName selectImageName:nil backgroundColor:nil];

}

+ (UIButton *)XTJ_createWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(NSInteger)font selectTitle:(NSString *)selectTitle imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName  backgroundColor:(UIColor *)backgroundColor {
    
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = backgroundColor?backgroundColor:[UIColor jk_colorWithHex:0xF6F6F6];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [<#view#> addSubview:button];

    return button;
}
@end
