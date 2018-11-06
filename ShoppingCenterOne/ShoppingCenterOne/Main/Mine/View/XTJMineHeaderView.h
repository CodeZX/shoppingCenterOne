//
//  XTJMineHeaderView.h
//  TJShop
//
//  Created by tunjin on 2018/4/17.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XTJMineHeaderView;
@protocol  XTJMineHeaderViewDelegate <NSObject>
@optional
- (void)mineHeaderView:(XTJMineHeaderView *)headerView didLogin:(UIButton *)LoginBtn;
- (void)mineHeaderView:(XTJMineHeaderView *)headerView didRegister:(UIButton *)RegisterBtn;
- (void)mineHeaderView:(XTJMineHeaderView *)headerView didPortrait:(UIImageView *)potritImageView;
@required
@end
@interface XTJMineHeaderView : UIView

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic,weak) id<XTJMineHeaderViewDelegate> delegate;

- (void)setupData;
@end
