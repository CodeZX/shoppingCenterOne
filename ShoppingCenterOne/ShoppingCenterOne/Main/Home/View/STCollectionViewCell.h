//
//  XTJCollectionViewCell.h
//  TJShop
//
//  Created by 周鑫 on 2018/7/24.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STCollectionViewCell;
@protocol  STCollectionViewCellDelegate <NSObject>
@optional
- (void)collectionViewCell:(STCollectionViewCell *)cell didBuyNoe:(UIButton *)buyNoeBtn;
@required
@end

@class STGoodsModel;
@interface STCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) STGoodsModel *goodsModel;
@property (nonatomic,weak) id<STCollectionViewCellDelegate> delagate;
@end
