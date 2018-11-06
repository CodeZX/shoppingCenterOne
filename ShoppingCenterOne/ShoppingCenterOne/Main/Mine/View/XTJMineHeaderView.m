//
//  XTJMineHeaderView.m
//  TJShop
//
//  Created by tunjin on 2018/4/17.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMineHeaderView.h"
#define KIconeImageWidth   80

@interface XTJMineHeaderView()

@property (nonatomic,weak) UIButton *loginBtn;
@property (nonatomic,weak) UIButton *registerBtn;
@end

@implementation XTJMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tj_setUI];
        [self setupData];
    }
    return self;
}

- (void) tj_setUI {
    
    [self addSubview:self.bgImageView];
    
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KIconeImageWidth);
        make.width.mas_equalTo(KIconeImageWidth);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
//        make.width.mas_equalTo(self.width);
    }];
    
    // 登录
    UIButton *loginBtn = [UIButton XTJ_createWithTitle:@"登录" titleColor:[UIColor whiteColor] font:14 selectTitle:nil imageName:nil selectImageName:nil backgroundColor:[UIColor clearColor]];
    [self addSubview:loginBtn];
    self.loginBtn = loginBtn;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(10);
        make.right.equalTo(self.iconImageView.centerX).offset(-10);
        make.size.equalTo(CGSizeMake(30, 20));
    }];
   
    //注册
    UIButton *registerBtn = [UIButton XTJ_createWithTitle:@"注册" titleColor:[UIColor whiteColor] font:14 selectTitle:nil imageName:nil selectImageName:nil backgroundColor:[UIColor clearColor]];
    [self addSubview:registerBtn];
    self.registerBtn = registerBtn;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(10);
        make.left.equalTo(self.iconImageView.centerX).offset(10);
        make.size.equalTo(CGSizeMake(30,20));
    }];
    
}

- (void)setupData {
    
    userModel *user =  [UsersManager sharedUsersManager].currentUser;
    if (user) {
        self.nameLabel.hidden = NO;
        self.loginBtn.hidden = YES;
        self.registerBtn.hidden = YES;
        self.nameLabel.text = user.name;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_pic] placeholderImage:nil];
    }else {
        
        self.nameLabel.hidden = YES;
        self.loginBtn.hidden = NO;
        self.registerBtn.hidden = NO;
    }
}

- (void)loginBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(mineHeaderView:didLogin:)]) {
        [self.delegate mineHeaderView:self didLogin:btn];
    }
}

- (void)registerBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(mineHeaderView:didRegister:)]) {
        [self.delegate
         mineHeaderView:self didRegister:btn];
    }
}

- (void)tapIcon:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(mineHeaderView:didPortrait:)]) {
        
        [self.delegate mineHeaderView:self didPortrait:self.iconImageView];
    }
}

#pragma mark - 懒加载
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        _bgImageView.backgroundColor = [UIColor redColor];
        [_bgImageView setImage:[UIImage imageNamed:@"bg"]];
    }
    return _bgImageView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = KIconeImageWidth * 0.5;
        _iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIcon:)];
        [_iconImageView addGestureRecognizer:tap];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.hidden = YES;
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}


@end
