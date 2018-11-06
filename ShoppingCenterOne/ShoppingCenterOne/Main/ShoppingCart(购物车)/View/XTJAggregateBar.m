//
//  XTJAggregateBar.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/22.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJAggregateBar.h"
#import "XTJGoodsModel.h"

@interface XTJAggregateBar ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *settleAccountsBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkAllBtn;


@property (nonatomic,strong) NSString * currentPrice;
@property (nonatomic,strong) NSString * currentcuont;
@end
@implementation XTJAggregateBar

+ (instancetype)aggregateBar {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XTJAggregateBar" owner:self options:nil]lastObject];
}

- (void)awakeFromNib {
     [super awakeFromNib];

}

- (void)setPrice:(NSString *)price {
    
    self.currentPrice = price;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",price];
}

- (void)setCount:(NSString *)cuont {
    
    if ([cuont intValue] == 0) {
        self.checkAllBtn.selected = NO;
    }
    self.currentcuont = cuont;
    NSString *title = [NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"settleAccounts", @"结算"),cuont];
    [self.settleAccountsBtn setTitle:title forState:UIControlStateNormal];
}


- (void)addPriceAndCount:(XTJGoodsModel *)goodsModel {
    
    if (!goodsModel) {
        return;
    }
    
    CGFloat price = [self.currentPrice floatValue] + [goodsModel.price floatValue];
    [self setPrice:[NSString stringWithFormat:@"%.2f",price]];
    
    int count = [self.currentcuont floatValue] + 1;
    [self setCount:[NSString stringWithFormat:@"%d",count]];
    if ([self.delegate respondsToSelector:@selector(numberGoodsInAggregateBar:)]) {
        if (count == [self.delegate numberGoodsInAggregateBar:self]) {
            self.checkAllBtn.selected = YES;
        }
    }
    
}

- (void)reducePriceAndCount:(XTJGoodsModel *)gooodsModel {
    
    if (!gooodsModel) {
        return;
    }
    self.checkAllBtn.selected = NO;
    CGFloat price = [self.currentPrice floatValue] - [gooodsModel.price floatValue];
    [self setPrice:[NSString stringWithFormat:@"%.2f",price]];
    
    int count = [self.currentcuont floatValue] - 1;
    [self setCount:[NSString stringWithFormat:@"%d",count]];
}
- (IBAction)settleAccountsBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(aggregateBar:didSettleAccountsWithcheckAllStatus:)]) {
        [self.delegate aggregateBar:self didSettleAccountsWithcheckAllStatus:self.checkAllBtn.selected];
    }
    
}

- (void)setcheckAllBtnSelect:(BOOL)select {
    
    self.checkAllBtn.selected = select;
    if (!select) {
        [self setPrice:@"0"];
        [self setCount:[NSString stringWithFormat:@"%d",0]];
    }else {
        
        
    }
    
}

- (IBAction)checkAllBtn:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;

    if ([self.delegate respondsToSelector:@selector(aggregateBar:didSelectedWithcheckAllStatus:)]) {
        [self.delegate aggregateBar:self didSelectedWithcheckAllStatus:btn.selected];
    }
}




@end
