//
//  UILabel+XTJCreate.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "UILabel+XTJCreate.h"

@implementation UILabel (XTJCreate)
+ (UILabel *)XTJ_createWithTitle:(NSString *)title {
    
    return [self XTJ_createWithTitle:@"无效赋值" titleColor:nil font:0 textAlignment:0];
}
+ (UILabel *)XTJ_createWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(NSInteger)font textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font?:14];
    label.text = title?:@"无效赋值";
    label.textColor = titleColor?:[UIColor blackColor];
    label.textAlignment = textAlignment?:NSTextAlignmentLeft;
    label.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    //    label.backgroundColor = [UIColor clearColor];
    return label;
    
}
@end
