//
//  XTJAggregateBar.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/22.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTJAggregateBar,XTJGoodsModel;
@protocol  XTJAggregateBarDelegate <NSObject>
@optional
- (void)aggregateBar:(XTJAggregateBar *)aggregateBar didSettleAccountsWithcheckAllStatus:(BOOL)checkAllStatus;
- (void)aggregateBar:(XTJAggregateBar *)aggregateBar didSelectedWithcheckAllStatus:(BOOL)checkAllStatus;
- (NSInteger)numberGoodsInAggregateBar:(XTJAggregateBar *)aggregateBar;
@required
@end
@interface XTJAggregateBar : UIView
+ (instancetype)aggregateBar;
- (void)setPrice:(NSString *)price;
- (void)setCount:(NSString *)cuont;
- (void)addPriceAndCount:(XTJGoodsModel *)goodsModel;
- (void)reducePriceAndCount:(XTJGoodsModel *)goodsModel;
- (void)setcheckAllBtnSelect:(BOOL)select;
@property (nonatomic,weak) id<XTJAggregateBarDelegate> delegate;
@end
