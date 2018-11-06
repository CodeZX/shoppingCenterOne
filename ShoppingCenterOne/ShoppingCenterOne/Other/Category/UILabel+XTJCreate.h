//
//  UILabel+XTJCreate.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XTJCreate)
+ (UILabel *)XTJ_createWithTitle:(NSString *)title;
+ (UILabel *)XTJ_createWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(NSInteger)font textAlignment:(NSTextAlignment)textAlignment;
@end
