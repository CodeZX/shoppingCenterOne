//
//  XTJMyOrderCell.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTJOrderModel,XTJMyOrderCell;
@protocol  myOrderCellDelegate <NSObject>
@optional
- (void)myOrderCell:(XTJMyOrderCell *)myOrderCell didAction:(XTJOrderModel *)orderModel;

@required
@end
@interface XTJMyOrderCell : UITableViewCell

@property (nonatomic,strong) XTJOrderModel *orderModer;
@property (nonatomic,weak) id<myOrderCellDelegate> delegate;
@end
