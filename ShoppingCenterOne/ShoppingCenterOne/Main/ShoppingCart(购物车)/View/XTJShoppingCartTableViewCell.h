//
//  XTJShoppingCartTableViewCell.h
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XTJShoppingCartTableViewCell,XTJGoodsModel;
@protocol  shoppingCartTableViewCellDelegate <NSObject>
@optional
- (void)shoppingCartTableViewCell:(XTJShoppingCartTableViewCell *)shoppingCartTableViewCell didSelectedGooods:(XTJGoodsModel *)goodsModel;
- (void)shoppingCartTableViewCell:(XTJShoppingCartTableViewCell *)shoppingCartTableViewCell didUnSelectedGooods:(XTJGoodsModel *)goodsModel;
@required
@end
@interface XTJShoppingCartTableViewCell : UITableViewCell
@property (nonatomic,strong) XTJGoodsModel *goodsMdoel;
@property (nonatomic,weak) id<shoppingCartTableViewCellDelegate> delegate;
@end
