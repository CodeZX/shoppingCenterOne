//
//  XTJConfirmAnOrderCell.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STGoodsModel,STConfirmAnOrderCell;

@protocol  STConfirmAnOrderCellDelegate <NSObject>
@optional
- (void)confirmAnOrderCell:(STConfirmAnOrderCell *)confirmAnOrderCell didCChangeAmount:(NSInteger )amout;
@required
@end
@interface STConfirmAnOrderCell : UITableViewCell
@property (nonatomic,strong) STGoodsModel *goodsModel;
@property (nonatomic,weak) id<STConfirmAnOrderCellDelegate> delegate;
@end
