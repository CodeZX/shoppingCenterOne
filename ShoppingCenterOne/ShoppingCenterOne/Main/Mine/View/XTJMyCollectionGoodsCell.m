//
//  XTJMyCollectionGoodsCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMyCollectionGoodsCell.h"
#import "STGoodsModel.h"

@interface XTJMyCollectionGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation XTJMyCollectionGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoodsModel:(STGoodsModel *)goodsModel {
    
    _goodsModel = goodsModel;
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.product_pic]];
    self.titleLabel.text = goodsModel.name;
    
}
@end
