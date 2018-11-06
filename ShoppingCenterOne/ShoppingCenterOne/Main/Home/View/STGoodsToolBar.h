//
//  XTJGoodsToolBar.h
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STGoodsToolBar;
@protocol  STGoodsToolBarDelegate <NSObject>
@optional
- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickStoreBtn:(UIButton *)storeBtn;
- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickShoppingCartBtn:(UIButton *)shoppingCartBtn;
- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickBuyNowBtn:(UIButton *)BuyNowBtn;
- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickaddToShoppingCartBtn:(UIButton *)BuyNowBtn;
@required
@end
@interface STGoodsToolBar : UIView
@property (nonatomic,weak) id<STGoodsToolBarDelegate> delegate;

@end
