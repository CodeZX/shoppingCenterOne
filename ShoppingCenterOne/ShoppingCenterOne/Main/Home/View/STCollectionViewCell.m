//
//  XTJCollectionViewCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/24.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STCollectionViewCell.h"

#import "STGoodsModel.h"

@interface STCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photograph;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBtn;

@end
@implementation STCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.BuyNowBtn.userInteractionEnabled = NO;
}
- (void)setGoodsModel:(STGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
//    NSLog(@"%@",goodsModel.name);
    [self.photograph sd_setImageWithURL:[NSURL URLWithString:goodsModel.product_pic] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = goodsModel.name;
    self.priceLabel.text = goodsModel.price;
}
- (IBAction)BuyNow:(id)sender {
    
}

@end
