//
//  XTJGoodsDetailsView.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsDetailsView.h"
#import "XTJSliderScrollView.h"
#import "STGoodsModel.h"

@interface STGoodsDetailsView ()<SliderScrollViewNetDelegate>


@property (nonatomic,strong) XTJSliderScrollView *goodsPhotographs;
@property (nonatomic,strong) NSArray *sliderImageArray;

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIView *containerView;

//  描述
@property (nonatomic,weak) UIView *describeView;
// 现价
@property (nonatomic,weak) UILabel *currentPriceLabel;
// 原价
@property (nonatomic,weak) UILabel *originalPriceLabel;
// 标题
@property (nonatomic,weak) UILabel *titleLabel;



// 尺寸和参数
@property (nonatomic,weak) UIView *sizeAndParameterView;
// 详情
@property (nonatomic,weak) UIView *detailedView;

@property (nonatomic,strong) STGoodsModel *goodsModel;


@end
@implementation STGoodsDetailsView

- (instancetype)initWithGoodsModel:(STGoodsModel *)goodsModel {
    
    if (!goodsModel) {  return  nil;  }
   
    self = [super init];
    if (self) {
        self.goodsModel = goodsModel;
        [self setupData];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    

    UIScrollView *scrollView  = [[UIScrollView alloc]init];
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
   

    UIView *containerView = [[UIView alloc]init];
    containerView.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    [self.scrollView addSubview:containerView];
    self.containerView = containerView;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
//        make.height.mas_equalTo(1000);
    }];
//
     [containerView addSubview:self.goodsPhotographs];
    [self createDescribeView];
    [self createSizeAndParameterView];
    [self createDetailedView];
}

- (void)setupData {
    
   
    
}
- (void)createDescribeView {
    
    __weak typeof(self) weakSelf = self;
    UIView *describeView = [[UIView alloc]init];
    describeView.backgroundColor = [UIColor jk_colorWithHex:0xffffff];
    [self.containerView  addSubview:describeView];
    self.describeView = describeView;
    [self.describeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.containerView.left);
        make.top.equalTo(weakSelf.goodsPhotographs.bottom);
        make.height.equalTo(120);
        make.width.equalTo(weakSelf.containerView);
    }];
    
    //  现价
    UILabel *currentPriceLabel = [self createlabelWithText:self.goodsModel.price textColor:[UIColor jk_colorWithHex:0xD54851] font:22];
    [self.describeView addSubview:currentPriceLabel];
    self.currentPriceLabel = currentPriceLabel;
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.describeView.top).offset(10);
        make.left.equalTo(weakSelf.describeView.left).offset(15);
        make.height.equalTo(30);
    }];
    
    // 原价
    UILabel *originalpriceLabel = [self createlabelWithText:@"原价 120.00" textColor:[UIColor jk_colorWithHex:0x666666] font:12];
    [self.describeView addSubview:originalpriceLabel];
    self.originalPriceLabel = originalpriceLabel;
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.currentPriceLabel.bottom).offset(1);
        make.left.equalTo(weakSelf.containerView.left).offset(15);
        make.height.equalTo(20);
    }];
   
    //标题
    UILabel *titleLabel = [self createlabelWithText:self.goodsModel.name textColor:[UIColor jk_colorWithHex:0x333333] font:12];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.describeView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.originalPriceLabel.bottom).offset(10);
        make.left.equalTo(weakSelf.containerView.left).offset(15);
        make.right.equalTo(weakSelf.containerView.right).offset(-68);
        make.height.lessThanOrEqualTo(42);
    }];
    
    
    
    
    
}



- (void)createSizeAndParameterView {
    
    
    __weak typeof(self) weakSelf = self;
    UIView *sizeAndParameterView = [[UIView alloc]init];
    sizeAndParameterView.backgroundColor = [UIColor jk_colorWithHex:0xffffff];
    [self.containerView  addSubview:sizeAndParameterView];
    self.sizeAndParameterView = sizeAndParameterView;
    [self.sizeAndParameterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left);
        make.top.equalTo(weakSelf.describeView.bottom).offset(20);
        make.height.equalTo(86);
        make.width.equalTo(weakSelf.containerView);
    }];
    // 尺寸
    
    UILabel *sizeTitleLabel = [self createlabelWithText:NSLocalizedString(@"select", @"选择") textColor:[UIColor jk_colorWithHex:0x8B8B8B] font:13];
    [self.sizeAndParameterView addSubview:sizeTitleLabel];
    [sizeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sizeAndParameterView.left).offset(25);
        make.top.equalTo(sizeAndParameterView.top).offset(15);
        
    }];
    UILabel *sizeContentLabel = [self createlabelWithText:NSLocalizedString(@"select_size", @"请选择 尺寸") textColor:[UIColor jk_colorWithHex:0x393939] font:13];
    [self.sizeAndParameterView addSubview:sizeContentLabel];
    [sizeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sizeTitleLabel.right).offset(15);
        make.top.equalTo(sizeTitleLabel.top);
        
    }];
    
    UIImageView *sizeIndicateImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_detail"]];
//    sizeIndicateImageView.backgroundColor = RandomColor;
    [self.sizeAndParameterView addSubview:sizeIndicateImageView];
    [sizeIndicateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sizeContentLabel.top);
        make.right.equalTo(sizeAndParameterView.right).offset(-20);
        make.size.equalTo(CGSizeMake(7, 12));
        
    }];
    UIButton *sizeBtn = [[UIButton alloc]init];
    [sizeBtn addTarget:self action:@selector(sizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sizeBtn];
    [sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.sizeAndParameterView);
        make.height.equalTo(weakSelf.sizeAndParameterView.height).multipliedBy(.5);
    }];
    
    //参数
    UILabel *parameterTitleLabel = [self createlabelWithText:NSLocalizedString(@"parameter", @"参数") textColor:[UIColor jk_colorWithHex:0x8B8B8B] font:13];
    [self.sizeAndParameterView addSubview:parameterTitleLabel];
    [parameterTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sizeAndParameterView.left).offset(25);
        make.top.equalTo(sizeTitleLabel.bottom).offset(20);
        

    }];
    UILabel *parameterContentLabel = [self createlabelWithText:NSLocalizedString(@"parameterSelect", @"风格 品牌") textColor:[UIColor jk_colorWithHex:0x393939] font:13];
    [self.sizeAndParameterView addSubview:parameterContentLabel];
    [parameterContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(parameterTitleLabel.right).offset(15);
        make.top.equalTo(parameterTitleLabel);

    }];
    UIButton *parameterBtn = [[UIButton alloc]init];
    [parameterBtn addTarget:self action:@selector(parameterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:parameterBtn];
    [parameterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sizeAndParameterView.centerY);
        make.left.right.equalTo(weakSelf.sizeAndParameterView);
        make.height.equalTo(weakSelf.sizeAndParameterView.height).multipliedBy(.5);
    }];

    UIImageView *parameterIndicateImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_detail"]];
//    parameterIndicateImageView.backgroundColor = RandomColor;
    [self.sizeAndParameterView addSubview:parameterIndicateImageView];
    [parameterIndicateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parameterContentLabel);
        make.right.equalTo(sizeAndParameterView.right).offset(-20);
         make.size.equalTo(CGSizeMake(7, 12));

    }];
    
    
}

- (void)createDetailedView {
    
    __weak typeof(self) weakSelf = self;
    UIView *detailedView = [[UIView alloc]init];
    detailedView.backgroundColor = [UIColor jk_colorWithHex:0xffffff];
    [self.containerView  addSubview:detailedView];
    self.detailedView = detailedView;
    [self.detailedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.left);
        make.top.equalTo(weakSelf.sizeAndParameterView.bottom).offset(20);
        //        make.height.equalTo(100);
        make.width.equalTo(weakSelf.containerView);
    }];
    
    NSString *details = self.goodsModel.detail;
    UILabel *detailsLabel =  [self createlabelWithText:details textColor:[UIColor jk_colorWithHex:0x333333] font:13];
    detailsLabel.numberOfLines = 0;
    [self.detailedView addSubview:detailsLabel];
    [detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailedView).offset(20);
        make.left.equalTo(detailedView).offset(20);
        make.right.equalTo(detailedView).offset(-20);
    }];
    [self.detailedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detailsLabel.bottom);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detailedView.bottom).offset(20);
    }];
}

- (void)sizeBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(selectSizeForGoodsDetailsView:)]) {
        [self.delegate selectSizeForGoodsDetailsView:self];
    }
    
}

- (void)parameterBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(selectParameterForGoodsDetailsView:)]) {
        [self.delegate selectParameterForGoodsDetailsView:self];
    }
    
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


#pragma mark -------------------------- lazy load ----------------------------------------


#pragma mark - 懒加载
- (XTJSliderScrollView *)goodsPhotographs {
    if (!_goodsPhotographs) {
        _goodsPhotographs = [[XTJSliderScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * 0.4) WithNetImages:self.sliderImageArray];
//        _goodsPhotographs.backgroundColor = [UIColor blueColor];
        /** 设置滚动延时*/
        _goodsPhotographs.autoScrollDelay = 3;
        /** 设置占位图 */
        _goodsPhotographs.placeholderImage = [UIImage imageNamed:@"00001"];
        /** 获取网络图片的index*/
//        _goodsPhotographs.netDelagate = self;
        
    }
    return _goodsPhotographs;
}

- (NSArray *)sliderImageArray {
    if (!_sliderImageArray) {
//        _sliderImageArray =  @[@"http://imgsrc.baidu.com/imgad/pic/item/5366d0160924ab186af90c153ffae6cd7b890b21.jpg",@"http://image.tianjimedia.com/uploadImages/2014/218/16/9CVKY480KLI9.jpg",@"http://pic1.win4000.com/wallpaper/a/59c3756a10443.jpg",@"http://old.bz55.com/uploads/allimg/140506/137-140506094H6-50.jpg"];
        _sliderImageArray = @[
                            self.goodsModel.product_pic,
                            self.goodsModel.product_pic
                        ];
    }
    return _sliderImageArray;
}

@end
