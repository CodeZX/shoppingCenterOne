//
//  XTJMyOrderCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMyOrderCell.h"
#import "XTJOrderModel.h"

@interface XTJMyOrderCell ()
@property (weak, nonatomic) IBOutlet UILabel *dateLable;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *otalPricesLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountlabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@end
@implementation XTJMyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderModer:(XTJOrderModel *)orderModer {
    
    _orderModer = orderModer;
    
    
    if ([orderModer.type isEqualToString:@"0"]) {
        [self.actionBtn setTitle:@"联系店家" forState:UIControlStateNormal];
    }else if ([orderModer.type isEqualToString:@"1"]) {
        [self.actionBtn setTitle:@"付款" forState:UIControlStateNormal];
    }else if ([orderModer.type isEqualToString:@"2"]) {
        [self.actionBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    self.dateLable.text = orderModer.date;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:orderModer.product_pic]];
    self.nameLabel.text = orderModer.product_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",orderModer.price];
    self.otalPricesLabel.text = [NSString stringWithFormat:@"合计: ￥%@",orderModer.total];
    self.amountlabel.text = [NSString stringWithFormat:@"共计%@件商品",orderModer.num];
    
}
- (IBAction)actionBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(myOrderCell:didAction:)]) {
        [self.delegate myOrderCell:self didAction:self.orderModer];
    }
}

@end
