//
//  XTJGoodsSizeSelectView.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/26.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsSizeSelectView.h"
#import "STGoodsModel.h"


@interface STGoodsSizeSelectView ()

@property (nonatomic,strong) STGoodsModel *goodsModel;


// 图片
@property (nonatomic,weak) UIImageView *photographImageView;
// 价格
@property (nonatomic,weak) UILabel  *priceLabel;
// 描述
@property (nonatomic,weak) UILabel  *describeLabel;
// 类型
@property (nonatomic,weak) UILabel  *typeLabel;
// 数量
@property (nonatomic,weak) UILabel  *amountLabel;

@property (nonatomic,weak) UILabel *numberLabel;

@end
@implementation STGoodsSizeSelectView

- (instancetype)initWithFrame:(CGRect)frame goodsModel:(STGoodsModel *)goodsModel {
    self = [super initWithFrame:frame];
    if (self) {
        self.goodsModel = goodsModel;
        [self setupUI];
    }
    return self;
    
}

-(void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    
    __weak typeof(self) weakSelf = self;
    
    // 图片
    UIImageView *photographImageView = [[UIImageView alloc]init];
    [photographImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.product_pic]];
    [self addSubview:photographImageView];
    self.photographImageView = photographImageView;
    [self.photographImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.size.equalTo(CGSizeMake(100, 100));
        
    }];
    // 价格
    UILabel *priceLabel = [self createlabelWithText:self.goodsModel.price textColor:[UIColor jk_colorWithHex:0xD54851] font:22];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(photographImageView);
        make.left.equalTo(photographImageView.right).offset(25);
    }];
    // 描述
    UILabel *describeLabel = [self createlabelWithText:self.goodsModel.name textColor:[UIColor jk_colorWithHex:0x3A3A3A] font:12];
    describeLabel.text = @"";
    [self addSubview:describeLabel];
    self.describeLabel = describeLabel;
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel);
        make.right.equalTo(weakSelf).offset(-20);
        make.top.equalTo(priceLabel.bottom).offset(10);
    }];
    
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
        make.size.equalTo(CGSizeMake(18, 18));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor jk_colorWithHex:0xE5E5E5];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(13);
        make.right.equalTo(weakSelf).offset(-13);
        make.top.equalTo(photographImageView.bottom).offset(15);
        make.height.equalTo(.5);
    }];

    
    //  类型
    UILabel *typeLabel = [self createlabelWithText:@"食品口味" textColor:[UIColor jk_colorWithHex:0x3A3A3A] font:14];
    [self addSubview:typeLabel];
    self.typeLabel = typeLabel;
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(20);
        make.left.equalTo(weakSelf.left).offset(12);
    }];
    
    UIButton *defaultTypeBth = [UIButton XTJ_createWithTitle:@"默认" titleColor:[UIColor lightGrayColor] font:13 selectTitle:nil imageName:nil selectImageName:nil backgroundColor:nil];
    defaultTypeBth.layer.borderWidth = 1;
    defaultTypeBth.layer.borderColor = [UIColor lightGrayColor].CGColor;
    defaultTypeBth.layer.cornerRadius = 5;
    defaultTypeBth.layer.masksToBounds = YES;
    [self addSubview:defaultTypeBth];
    [defaultTypeBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.bottom).offset(10);
        make.left.equalTo(typeLabel).offset(10);
        make.size.equalTo(CGSizeMake(100, 20));
    }];
    
    
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor jk_colorWithHex:0xE5E5E5];
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(13);
        make.right.equalTo(weakSelf).offset(-13);
        make.top.equalTo(typeLabel.bottom).offset(45);
        make.height.equalTo(.5);
    }];
    
    //  数量
    UILabel *amountLabel = [self createlabelWithText:@"购买数量" textColor:[UIColor jk_colorWithHex:0x3A3A3A] font:14];
    [self addSubview:amountLabel];
    self.amountLabel = amountLabel;
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.bottom).offset(80);
        make.left.equalTo(weakSelf.left).offset(20);
    }];
    
    UIImageView *addAndSubtractImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_number"]];
//    addAndSubtractImageView.backgroundColor = [UIColor redColor];
    addAndSubtractImageView.userInteractionEnabled  = YES;
    [self addSubview:addAndSubtractImageView];
    [addAndSubtractImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10);
        make.top.equalTo(lineView1).offset(15);
        make.size.equalTo(CGSizeMake(95, 25));
    }];
    
    UILabel *numberLabel = [self createlabelWithText:@"1" textColor:[UIColor jk_colorWithHex:0x353535] font:13];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [addAndSubtractImageView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(addAndSubtractImageView);
        make.size.equalTo(CGSizeMake(45, 25));
    }];
    
    UIButton *addBtn = [[UIButton alloc]init];
//    addBtn.backgroundColor = [UIColor redColor];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addAndSubtractImageView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addAndSubtractImageView);
        make.top.equalTo(addAndSubtractImageView);
        make.size.equalTo(CGSizeMake(25, 25));
    }];

    UIButton *subtractBtn = [[UIButton alloc]init];
    [subtractBtn addTarget:self action:@selector(subtractBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addAndSubtractImageView addSubview:subtractBtn];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addAndSubtractImageView);
        make.top.equalTo(addAndSubtractImageView);
        make.size.equalTo(CGSizeMake(25, 25));
    }];
    
    
}

- (void)addBtnClick:(UIButton *)btn {
    
    NSInteger numberValue = [self.numberLabel.text integerValue];
    numberValue++;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",numberValue];
    
}

- (void)subtractBtnClick:(UIButton *)btn {
    
    
    NSInteger numberValue = [self.numberLabel.text integerValue];
    if (numberValue == 1) {
        return;
    }
    numberValue--;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",numberValue];
}

- (void)closeBtnClicked:(UIButton *)btn {
    
    [UIView animateWithDuration: .5 animations:^{
        self.frame = CGRectMake(0, DEVICE_SCREEN_HEIGHT, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * .3);
    }];
}

- (UILabel *)createlabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(NSInteger)font    {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
    
}


@end
