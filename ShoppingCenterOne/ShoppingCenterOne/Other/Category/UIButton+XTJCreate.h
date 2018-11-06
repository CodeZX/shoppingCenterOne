//
//  UIButton+XTJCreate.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XTJCreate)

+ (UIButton *)XTJ_createWithTitle:(NSString *)title imageName:(NSString *)imageName;
+ (UIButton *)XTJ_createWithTitle:(NSString *)title titleColor:(UIColor *)titleColor  font:(NSInteger)font selectTitle:(NSString *)selectTitle imageName:(NSString *)imageName selectImageName:(NSString *)selctImageName backgroundColor:(UIColor *)backgroundColor;
@end
