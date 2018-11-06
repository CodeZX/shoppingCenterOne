//
//  XTJMineTableViewCell.m
//  TJShop
//
//  Created by tunjin on 2018/4/17.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMineTableViewCell.h"
#import "XTJMineListModel.h"

@implementation XTJMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setMineListModel:(XTJMineListModel *)mineListModel {
    
    _mineListModel = mineListModel;
    self.imageView.image = [UIImage imageNamed:mineListModel.leftImageName];
    self.textLabel.text = mineListModel.title;
    
}

@end
