//
//  XTJShoppingCartTableViewCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJShoppingCartTableViewCell.h"
#import "XTJGoodsModel.h"

@interface XTJShoppingCartTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end
@implementation XTJShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoodsMdoel:(XTJGoodsModel *)goodsMdoel {
    
    _goodsMdoel = goodsMdoel;
    if (goodsMdoel.selected) {
        self.selectedBtn.selected = YES;
    }
    self.titleLabel.text = goodsMdoel.name;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:goodsMdoel.product_pic]];
    self.priceLabel.text = goodsMdoel.price;
    
}
- (IBAction)reduceBtn:(id)sender {
    
    NSInteger numberValue = [self.amountTextField.text integerValue];
    if (numberValue == 1) {
        return;
    }
    numberValue--;
    self.amountTextField.text = [NSString stringWithFormat:@"%ld",numberValue];
}

- (IBAction)addBtn:(id)sender {
    
    NSInteger numberValue = [self.amountTextField.text integerValue];
    numberValue++;
    self.amountTextField.text = [NSString stringWithFormat:@"%ld",numberValue];
    
}
- (IBAction)selectBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.goodsMdoel.selected = btn.selected;
    
    if (self.goodsMdoel.selected) {
        if ([self.delegate respondsToSelector:@selector(shoppingCartTableViewCell:didSelectedGooods:)]) {
            [self.delegate shoppingCartTableViewCell:self didSelectedGooods:self.goodsMdoel];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(shoppingCartTableViewCell:didUnSelectedGooods:)]) {
            [self.delegate shoppingCartTableViewCell:self didUnSelectedGooods:self.goodsMdoel];
        }
        
    }
    
}


@end
