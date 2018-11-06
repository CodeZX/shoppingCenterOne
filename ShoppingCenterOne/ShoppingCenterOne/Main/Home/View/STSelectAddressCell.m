//
//  XTJSelectAddressCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STSelectAddressCell.h"
#import "STAddressModel.h"

@interface STSelectAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation STSelectAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAddressModel:(STAddressModel *)addressModel {
    _addressModel = addressModel;
    
    
    self.nameLabel.text = addressModel.receiver_name;
    self.phoneLabel.text = addressModel.receiver_phone;
    if ([addressModel.type isEqualToString:@"0"]) {
        
        NSString *addressString = [NSString stringWithFormat:@"【默认地址】%@",addressModel.address];
//        NSMutableString *mutableString = [NSMutableString stringWithString:addressString];
        NSMutableAttributedString *maString = [[NSMutableAttributedString alloc]initWithString:addressString];
//         NSForegroundColorAttributeName: [UIColor colorWithRed:0.130 green:0.854 blue:0.345 alpha:1.000]
        [maString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 6)];
        [maString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 6)];
        self.addressLabel.attributedText = maString;
    }else  {
        
         self.addressLabel.text = addressModel.address;
    }
   
}


@end
