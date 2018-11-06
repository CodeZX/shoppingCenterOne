//
//  XTJConfirmAnOrderViewController.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STGoodsModel;
@interface STConfirmAnOrderViewController : UIViewController
- (instancetype)initWithGoodsModel:(STGoodsModel *)goodsModel;
- (instancetype)initWithGooddModels:(NSArray<STGoodsModel *> *)goodsModels;
@end
