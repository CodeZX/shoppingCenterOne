//
//  XTJPersonalInfoCell.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJPersonalInfoCell.h"
#import "XTJPersonalInfoMdoel.h"
@interface XTJPersonalInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;

@end

@implementation XTJPersonalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPersonalInfoMdoel:(XTJPersonalInfoMdoel *)personalInfoMdoel {

    _personalInfoMdoel = personalInfoMdoel;
    self.titleLabel.text = personalInfoMdoel.title;
    if (personalInfoMdoel.content) {
        self.contentLabel.text = personalInfoMdoel.content;
        self.contentLabel.hidden  = NO;
        self.portraitImageView.hidden = YES;
    }else if(personalInfoMdoel.rightImageViewName) {
        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:personalInfoMdoel.rightImageViewName]];
        self.contentLabel.hidden = YES;
        self.portraitImageView.hidden  = NO;
    }
    
}

@end
