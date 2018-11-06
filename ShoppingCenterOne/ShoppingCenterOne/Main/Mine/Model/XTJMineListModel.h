//
//  XTJMineListModel.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^action)(id cell);

@interface XTJMineListModel : NSObject
@property (nonatomic,copy) NSString *leftImageName;
@property (nonatomic,copy)  NSString *title;
@property (nonatomic,copy) NSString *rightName;
@property (nonatomic,copy) action actionBlock;

- (instancetype)initWithLeftImageName:(NSString *)leftImageName title:(NSString *)title actionBlock:(action)actionBlock;
@end
