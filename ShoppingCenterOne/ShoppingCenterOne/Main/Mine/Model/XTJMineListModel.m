//
//  XTJMineListModel.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMineListModel.h"


@implementation XTJMineListModel

- (instancetype)initWithLeftImageName:(NSString *)leftImageName title:(NSString *)title actionBlock:(action)actionBlock {
    
    self = [super init];
    if (self) {
        self.leftImageName = leftImageName;
        self.title = title;
        self.actionBlock = actionBlock;
    }
    return self;
}

@end
