//
//  XTJConfirmAnOrderCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STConfirmAnOrderCell.h"
#import "STGoodsModel.h"

@interface STConfirmAnOrderCell ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@end
@implementation STConfirmAnOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addBtnClick:(id)sender {
    
    NSInteger numberValue = [self.numberLabel.text integerValue];
    numberValue++;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",numberValue];
    if ([self.delegate respondsToSelector:@selector(confirmAnOrderCell:didCChangeAmount:)]) {
        [self.delegate confirmAnOrderCell:self didCChangeAmount:[self.numberLabel.text integerValue]];
    }
}

- (IBAction)subtractBtnClick:(id)sender {
    
    NSInteger numberValue = [self.numberLabel.text integerValue];
    if (numberValue == 1) {
        return;
    }
    numberValue--;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",numberValue];
    if ([self.delegate respondsToSelector:@selector(confirmAnOrderCell:didCChangeAmount:)]) {
        [self.delegate confirmAnOrderCell:self didCChangeAmount:[self.numberLabel.text integerValue]];
    }
}

- (void)setGoodsModel:(STGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.product_pic]];
    self.nameLabel.text = goodsModel.name;
    self.priceLabel.text = goodsModel.price;
    
}


@end
