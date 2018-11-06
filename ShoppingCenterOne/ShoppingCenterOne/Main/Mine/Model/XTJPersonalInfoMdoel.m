//
//  XTJPersonalInfoMdoel.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJPersonalInfoMdoel.h"

@implementation XTJPersonalInfoMdoel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content rightImageViewName:(NSString *)rightImageViewName actionBlock:(action)actionBlock {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.rightImageViewName = rightImageViewName;
        self.actionBlock = actionBlock;
    }
    return self;
}
@end
