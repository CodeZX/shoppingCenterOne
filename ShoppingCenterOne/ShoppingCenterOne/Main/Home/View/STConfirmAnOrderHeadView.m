//
//  XTJConfirmAnOrderHeadView.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/9.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STConfirmAnOrderHeadView.h"
#import "STAddressModel.h"


@interface STConfirmAnOrderHeadView ()
@property (nonatomic,weak) UIButton *addAddressBtn;
@property (nonatomic,weak) UILabel *consigneeLabel;
@property (nonatomic,weak) UILabel *phoneLabel;
@property (nonatomic,weak) UIImageView *locationImageView;
@property (nonatomic,weak) UILabel *addressLabel;
@property (nonatomic,weak) UIImageView *indicateImageView;
@end
@implementation STConfirmAnOrderHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI {
    
    __weak typeof(self) weakSelf = self;
    UIButton *addAddressBtn = [UIButton XTJ_createWithTitle:@"添加收货地址" titleColor:BlackColor font:14 selectTitle:nil imageName:nil selectImageName:nil backgroundColor:WhiteColor];
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addAddressBtn];
    self.addAddressBtn = addAddressBtn;
    addAddressBtn.hidden = YES;
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    
    UILabel *consigneeLabel = [UILabel XTJ_createWithTitle:@"" titleColor:[UIColor jk_colorWithHex:0x595959] font:14 textAlignment:NSTextAlignmentLeft];
    [self addSubview:consigneeLabel];
    self.consigneeLabel = consigneeLabel;
    [consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(44);
        make.top.equalTo(self).offset(16);
        make.height.equalTo(14);
        make.width.greaterThanOrEqualTo(100);
    }];
    

    
    UILabel *phoneLabel = [UILabel XTJ_createWithTitle:@"" titleColor:[UIColor jk_colorWithHex:0x595959] font:14 textAlignment:NSTextAlignmentCenter];
    [self addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-34);
        make.top.equalTo(weakSelf).offset(16);
        make.height.equalTo(14);
        make.width.greaterThanOrEqualTo(100);
        }];
    
    UIImageView *locationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"位置"]];
    [self addSubview:locationImageView];
    self.locationImageView = locationImageView;
//    locationImageView.backgroundColor = 
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(14);
        make.top.equalTo(weakSelf).offset(40);
        make.size.equalTo(CGSizeMake(16, 16));
    }];
    
    UILabel *addressLabel = [UILabel XTJ_createWithTitle:@"" titleColor:[UIColor jk_colorWithHex:0x595959] font:14 textAlignment:NSTextAlignmentLeft];
    addressLabel.numberOfLines = 0;
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(44);
        make.right.equalTo(weakSelf).offset(-34);
        make.top.equalTo(consigneeLabel.bottom).offset(10);
        make.height.equalTo(14);
//        make.width.greaterThanOrEqualTo(200);
    }];
    
    
    UIImageView *indicateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_detail"]];
    [self addSubview:indicateImageView];
    self.indicateImageView = indicateImageView;
    //    indicateImageView.backgroundColor = [UIColor redColor];
    [indicateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-14);
        make.top.equalTo(weakSelf).offset(48);
        make.size.equalTo(CGSizeMake(10, 14 ));
    }];
    
    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHearView:)];
    [self addGestureRecognizer:tap];
    
}

- (void)setAddressModel:(STAddressModel *)addressModel {
    
    _addressModel = addressModel;
    if (addressModel) {
        self.consigneeLabel.text = addressModel.receiver_name;
        self.consigneeLabel.backgroundColor = [UIColor clearColor];
        self.phoneLabel.text = addressModel.receiver_phone;
        self.phoneLabel.backgroundColor = [UIColor clearColor];
        self.addressLabel.text = addressModel.address;
        self.addressLabel.backgroundColor = [UIColor clearColor];
        
    }else {
        self.addAddressBtn.hidden = NO;
        self.consigneeLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.locationImageView.hidden  = YES;
        self.addressLabel.hidden = YES;
        self.indicateImageView.hidden = YES;
    }
    
    
    
}

- (void)addAddressBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(confirmAnOrderHeadView:didAddAddress:)]) {
        [self.delegate confirmAnOrderHeadView:self didAddAddress:btn];
    }
    
}

- (void)tapHearView:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(confirmAnOrderHeadView:didSelectAddress:)]) {
        [self.delegate confirmAnOrderHeadView:self didSelectAddress:tap];
    }
    
    
}
@end
