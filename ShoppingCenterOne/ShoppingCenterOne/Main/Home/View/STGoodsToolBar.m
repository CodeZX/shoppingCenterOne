//
//  XTJGoodsToolBar.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsToolBar.h"

typedef NS_ENUM(NSUInteger,XTJGoodsToolBarType) {
    XTJGoodsToolBarTypeStore = 51,
    XTJGoodsToolBarTypeShoppingCart = 52,
    XTJGoodsToolBarTypeBuyNow = 53,
    XTJGoodsToolBarTypeaddToShoppingCart = 54
};

@interface STGoodsToolBar ()
// 店铺
@property (nonatomic,weak) UIButton *storeButton;
// 购物车
@property (nonatomic,weak) UIButton *shoppingCartButton;
// 加入购物车
@property (nonatomic,weak) UIButton *addToShoppingCartButton;
// 立即购买
@property (nonatomic,weak) UIButton *BuyNowButton;




@end
@implementation STGoodsToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    
    // 店铺
    UIButton *storeButton = [self createButtonWithTitle:NSLocalizedString(@"phone", @"电话") font:9 imageName:@"icon_store"];
    storeButton.tag = XTJGoodsToolBarTypeStore;
    [self addSubview:storeButton];
    self.storeButton = storeButton;
    [self.storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left).offset(20);
        make.right.equalTo(weakSelf.centerX).multipliedBy(.3);
        make.centerY.equalTo(weakSelf.centerY);
        make.height.equalTo(44);

    }];

    // 购物车
    UIButton *shoppingCartButton = [self createButtonWithTitle:NSLocalizedString(@"shoppingCart", @"购物车") font:9 imageName:@"icon_shopping"];
    shoppingCartButton.tag = XTJGoodsToolBarTypeShoppingCart;
    [self addSubview:shoppingCartButton];
    self.shoppingCartButton = shoppingCartButton;
    [self.shoppingCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeButton.right).offset(20);
//        make.right.equalTo(weakSelf.centerX);
        make.width.equalTo(storeButton);
        make.centerY.equalTo(weakSelf.centerY);
        make.height.equalTo(44);

    }];
    
    
    // 加入购物车
    UIButton *addToShoppingCartButton = [self createButtonWithTitle:NSLocalizedString(@"accedeToshoppingCart", @"加入购物车") font:9 imageName:nil];
    addToShoppingCartButton.layer.cornerRadius = 10;
    addToShoppingCartButton.layer.masksToBounds = YES;
    addToShoppingCartButton.tag = XTJGoodsToolBarTypeaddToShoppingCart;
    [addToShoppingCartButton setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    addToShoppingCartButton.backgroundColor = [UIColor orangeColor];
    [self addSubview:addToShoppingCartButton];
    self.addToShoppingCartButton = addToShoppingCartButton;
    [self.addToShoppingCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shoppingCartButton.right);
        make.right.equalTo(weakSelf.centerX).offset(-5);
        make.centerY.equalTo(weakSelf.centerY);
        make.height.equalTo(25);
        
        
    }];
    
    // 立即购买
    UIButton *BuyNowButton = [self createButtonWithTitle:NSLocalizedString(@"buy", @"立即购买") font:15 imageName:nil];
    BuyNowButton.tag = XTJGoodsToolBarTypeBuyNow;
    [BuyNowButton setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    BuyNowButton.backgroundColor = [UIColor redColor];
    [self addSubview:BuyNowButton];
    self.BuyNowButton = BuyNowButton;
    [self.BuyNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.width.equalTo(weakSelf.width).multipliedBy(.5);
        make.centerY.equalTo(weakSelf.centerY);
        make.height.equalTo(44);
        
        
    }];
    
    
}

- (UIButton *)createButtonWithTitle:(NSString *)title font:(NSInteger)font imageName:(NSString *)imageName{
    
    
    UIButton *button = [[UIButton alloc] init];
//    button.backgroundColor = RandomColor;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleTop imageTitleSpace:5 isSizeToFit:YES];
    return button;

}

- (void)buttonClicked:(UIButton *)btn {
    
    
    switch (btn.tag) {
        case XTJGoodsToolBarTypeStore: // 店铺
        {
            if ([self.delegate respondsToSelector:@selector(goodsToolBar:didClickStoreBtn:)]) {
                [self.delegate goodsToolBar:self didClickStoreBtn:btn];
            }
           break;
        }
        case XTJGoodsToolBarTypeShoppingCart: // 购物车
        {
            if ([self.delegate respondsToSelector:@selector(goodsToolBar:didClickShoppingCartBtn:)]) {
                [self.delegate goodsToolBar:self didClickShoppingCartBtn:btn];
            }
            break;
        }
        case XTJGoodsToolBarTypeBuyNow:  // 立即购买
        {
            if ([self.delegate respondsToSelector:@selector(goodsToolBar:didClickBuyNowBtn:)]) {
                [self.delegate goodsToolBar:self didClickBuyNowBtn:btn];
            }
            break;
        }
        case XTJGoodsToolBarTypeaddToShoppingCart:  // 加入购物车
        {
            if ([self.delegate respondsToSelector:@selector(goodsToolBar:didClickaddToShoppingCartBtn:)]) {
                [self.delegate goodsToolBar:self didClickaddToShoppingCartBtn:btn];
            }
            break;
            
        }
            
        default:
            break;
    }
}

@end
