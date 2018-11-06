//
//  XTJGoodsParameterView.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsParameterView.h"

@implementation STGoodsParameterView

- (instancetype)initWithFrame:(CGRect)frame goodsModel:(STGoodsModel *)goodsModel {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI {
    
   
    self.backgroundColor = WhiteColor;
    
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    __weak typeof(self) weakSelf = self;
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(5);
        make.right.equalTo(weakSelf).offset(-15);
        make.size.equalTo(CGSizeMake(18, 18));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.text = @"暂无信息";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
}

- (void)closeBtnClicked:(UIButton *)btn {
    
    [UIView animateWithDuration: .5 animations:^{
        self.frame = CGRectMake(0, DEVICE_SCREEN_HEIGHT, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * .3);
    }];
    
}
@end
