//
//  XTJPersonalInfoMdoel.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^action)(id cell);
@interface XTJPersonalInfoMdoel : NSObject

//@property (nonatomic,copy) NSString *leftImageName;
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,copy) NSString *rightImageViewName;
@property (nonatomic,copy) action actionBlock;

//- (instancetype)initWithLeftImageName:(NSString *)leftImageName title:(NSString *)title actionBlock:(action)actionBlock;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content rightImageViewName:(NSString *)rightImageViewName actionBlock:(action)actionBlock;
@end
