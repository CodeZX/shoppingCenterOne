//
//  STHomeCollectionTitleView.m
//  ShoppingCenterOne
//
//  Created by 周鑫 on 2018/11/1.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STHomeCollectionTitleView.h"


@interface STHomeCollectionTitleView  ()
@property (nonatomic,weak) UILabel *title;

@end
@implementation STHomeCollectionTitleView

- (instancetype)initWithFrame:(CGRect)frame  {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
//    self.backgroundColor = [UIColor jkoc];
    __weak typeof(self) weakSelf = self;
    UILabel *title = [[UILabel alloc]init];
    title.textAlignment = NSTextAlignmentCenter;
    title.text  = NSLocalizedString(@"commend", @"精选推荐");//@"精选推荐";
//    title.backgroundColor = [UIColor redColor];
    [self addSubview:title];
    self.title = title;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.height.equalTo(44);
        make.width.equalTo(100);
//        make.top.equalTo(weakSelf);
//        make.left.equalTo(weakSelf);
    }];
    
    
    UIView *leftLine = [[UIView alloc]init];
    leftLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf.title.left).offset(-10);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(1);
    }];
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-20);
        make.left.equalTo(weakSelf.title.right).offset(10);
        make.centerY.equalTo(weakSelf);
        make.height.equalTo(1);
    }];
    
    
}
@end
