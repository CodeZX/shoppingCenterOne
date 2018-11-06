//
//  XTJGoodsDetailsView.h
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STGoodsModel;
@class STGoodsDetailsView;
@protocol  STGoodsDetailsViewDelegate <NSObject>
@optional
- (void)selectSizeForGoodsDetailsView:(STGoodsDetailsView *)goodsDetailsView;
- (void)selectParameterForGoodsDetailsView:(STGoodsDetailsView *)goodsDetailsView;
@required
@end
@interface STGoodsDetailsView : UIView
- (instancetype)initWithGoodsModel:(STGoodsModel *)goodsModel;
@property (nonatomic,weak) id<STGoodsDetailsViewDelegate> delegate;
@end
