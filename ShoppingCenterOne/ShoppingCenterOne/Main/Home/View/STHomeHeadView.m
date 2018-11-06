//
//  STHomeHeadView.m
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STHomeHeadView.h"
#import "XTJSliderScrollView.h"
#import "STBannerModel.h"
#import "STHomeCategoryBtnModel.h"
#import "FHCTopLineView.h"

@interface STHomeHeadView ()<SliderScrollViewNetDelegate>

@property (nonatomic, strong) XTJSliderScrollView * sliderScrollView;
@property (nonatomic, strong) NSArray * sliderImageArray;///< 轮播图 图片数组

@property (nonatomic,weak) UIView *itemView;
@property (nonatomic,weak) UIButton *itemBtn1;
@property (nonatomic,weak) UIButton *itemBtn2;
@property (nonatomic,weak) UIButton *itemBtn3;
@property (nonatomic,weak) UIButton *itemBtn4;
@property (nonatomic,strong) NSMutableArray *itemBtnArray;
@property (nonatomic,strong) FHCTopLineView *topLineView1;


@property (nonatomic,weak) UIView *titleView;
@end

@implementation STHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupData];
        [self setupUI];
    }
    return  self;
}

- (void)setupData {
    self.sliderImageArray = @[@"",@"",@"",@""];
    
    
}

-(void)setupUI {
    
    self.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    [self addSubview:self.sliderScrollView];
    
    [self  createAllItems];
    [self createTitleView];
    [self createCommendView];
   
    
    
}

- (void)createCommendView {
    
    //    滚动字符
    self.topLineView1 = [[FHCTopLineView alloc] initWithFrame:CGRectMake(25, DEVICE_SCREEN_WIDTH/16*9 + 10,DEVICE_SCREEN_WIDTH - 50, 50)];
//    self.topLineView1.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topLineView1];
//    self.topLineView1.delegate = self;
    self.topLineView1.titlesGroup = @[[NSString TJ_localizableZHNsstring:@"好消息 还消息 好货上新了" enString:@"Good news, still news, good goods are new"],
                                      
       [NSString TJ_localizableZHNsstring: @"双11买一送一 全场最低5折起" enString:@"Double 11 buy one get one free and the whole game has a minimum of 50% off"],
        [NSString TJ_localizableZHNsstring:@"满100减10 满200减30 多买多减" enString:@"100 and 10 Full 200 minus 30 more buy more and less"]];
    //    热门推荐商品
    
    //   
    
}

- (void)createAllItems  {
    
    __weak typeof(self) weakSelf = self;
    CGFloat buttonH = 70;
    CGFloat buttonW = 70;
    CGFloat labelH = 16;
    CGFloat labelW = 52;
    CGFloat buttonTop = 10;
    CGFloat itemViewleftAndRigthSpace = 5;
    CGFloat itemViewTop = 55;
    CGFloat space = (DEVICE_SCREEN_WIDTH - 4 * buttonW - itemViewleftAndRigthSpace * 2)/5;
    CGFloat itemViewH = 100;
    
    UIView *itemView = [[UIView alloc]init];
    itemView.backgroundColor = [UIColor whiteColor];
    [self addSubview:itemView];
    self.itemView = itemView;
    [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sliderScrollView.bottom).offset(itemViewTop);
        make.left.equalTo(self).offset(itemViewleftAndRigthSpace);
        make.right.equalTo(self).offset(-itemViewleftAndRigthSpace);
        make.height.equalTo(itemViewH);
    }];
   
    // item1
    UIButton *itemBtn1 = [self createItemButtonWithTitle:NSLocalizedString(@"SnackFood",@"休闲食品") Font:12 ImageName:@"icon_1" Tag:100 + 11];
    [self.itemView addSubview:itemBtn1];
    self.itemBtn1 = itemBtn1;
    [self.itemBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemView.mas_left).mas_offset(space);
        make.top.equalTo(weakSelf.itemView).mas_offset(buttonTop);
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
    }];
    [self.itemBtnArray addObject:itemBtn1];
    
    
    // item2
    UIButton *itemBtn2 = [self createItemButtonWithTitle:NSLocalizedString(@"driedFruit", @"炒货干果") Font:12 ImageName:@"icon_2" Tag:100 + 12];
    [self.itemView addSubview:itemBtn2];
    self.itemBtn2 = itemBtn2;
    [self.itemBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemBtn1 .mas_right).mas_offset(space);
        make.top.equalTo(weakSelf.itemBtn1.top);
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
    }];
    [self.itemBtnArray addObject:itemBtn2];


    // item3  NSLocalizedString(@"biscuit",@"饼干糕点")
    UIButton *itemBtn3 = [self createItemButtonWithTitle:@"biscuit" Font:12 ImageName:@"icon_3" Tag:100 + 13];
    [self.itemView addSubview:itemBtn3];
//    itemBtn3.backgroundColor = [UIColor redColor];
    self.itemBtn3 = itemBtn3;
    [self.itemBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemBtn2 .right).mas_offset(space);
        make.top.equalTo(weakSelf.itemBtn2.top);
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
    }];
    [self.itemBtnArray addObject:itemBtn3];

    // item4
    UIButton *itemBtn4 = [self createItemButtonWithTitle:NSLocalizedString(@"import",@"进口食品") Font:12 ImageName:@"icon_4" Tag:100 + 14];
    [self.itemView addSubview:itemBtn4];
    self.itemBtn4 = itemBtn4;
    [self.itemBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemBtn3 .right).mas_offset(space);
        make.top.equalTo(weakSelf.itemBtn3.top);
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonH));
    }];
    [self.itemBtnArray addObject:itemBtn4];
    
    
    
}

- (void)createTitleView {
    
    CGFloat titleViewTop = 5;
    CGFloat titleViewH = 44;
    
    __weak typeof(self) weakSelf = self;
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview: titleView];
    self.titleView = titleView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.itemView.bottom).offset(titleViewTop);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.equalTo(titleViewH);
    }];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    //    titlelabel.backgroundColor = [UIColor redColor];
    titlelabel.text =  NSLocalizedString(@"pop", @"热卖商品");//@"热卖商品";
    titlelabel.textColor = [UIColor lightGrayColor];
    [titleView addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(10);
        make.centerY.equalTo(titleView);
        //        make.size.equalTo(CGSizeMake(100, 44));
    }];
    //
    
    UIButton *moreButton = [[UIButton alloc] init];
    //    button.backgroundColor = [UIColor <#backgroundColor#>];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [moreButton setTitle:NSLocalizedString(@"more", @"更多") forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"icon_detail"] forState:UIControlStateNormal];
    [moreButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleRight imageTitleSpace:5 isSizeToFit:YES];
    [moreButton addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleView).offset(-5);
        make.centerY.equalTo(titleView);
        make.size.equalTo(CGSizeMake(60, 40));
    }];
    
    
}
- (void)moreBtnClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeHeadView:didSelectedMoreBtn:)]) {
        [self.delegate homeHeadView:self didSelectedMoreBtn:btn];
    }
}

- (UIButton *)createItemButtonWithTitle:(NSString *)title Font:(NSInteger )font ImageName:(NSString *)imageName Tag:(NSInteger)tag{
    
    
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleTop imageTitleSpace:1 isSizeToFit:YES];
    
    return button;
}
- (void)ItemButtonClicked:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(homeHeadView:didSelectCategoryBtnAtIndex:)]) {
        [self.delegate homeHeadView:self didSelectCategoryBtnAtIndex:btn.tag - 111];
    }
    
}

- (UILabel *)crateItemLabel {
    
    
    UILabel *label = [[UILabel alloc] init];
    //    label.font = [UIFont <#font#>];
    label.text = @"item";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    //    [<#view#> addSubview:label];
    return label;
}


- (void)setBanner:(NSArray<STBannerModel *> *)bannerModels {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (STBannerModel *model in bannerModels) {
        [array  addObject:model.shop_pic];
    }
    self.sliderImageArray = array;
    
    //    [self.sliderScrollView removeFromSuperview];
    self.sliderScrollView = nil;
    [self addSubview:self.sliderScrollView];
    
    
}
- (void)setCategoryBtn:(NSArray<STHomeCategoryBtnModel *> *)categoryBtnModels {
    
    //    for (UIButton *itemBtn in self.itemBtnArray) {
    //
    //    }
    
    for (NSInteger index = 0; index < self.itemBtnArray.count; index++) {
        
        if(index < categoryBtnModels.count - 1) {
            
            UIButton *itemeBtn = self.itemBtnArray[index];
            STHomeCategoryBtnModel *categoryBtnModel = categoryBtnModels[index];
            [itemeBtn.imageView sd_setImageWithURL:[NSURL URLWithString:categoryBtnModel.shop_pic] placeholderImage:[UIImage imageNamed:@""]];
//            [itemeBtn setTitle:categoryBtnModel.category forState:UIControlStateNormal];
        }
    }
    
}


#pragma mark -------------------------- SliderScrollViewNetDelegate ----------------------------------------

/** 点中网络滚动视图后触发*/
-(void)didSelectedNetImageAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(homeHeadView:didSelectBannerAtIndex:)]) {
        [self.delegate homeHeadView:self didSelectBannerAtIndex:index];
    }
}



#pragma mark -------------------------- lazy load ----------------------------------------


#pragma mark - 懒加载
- (XTJSliderScrollView *)sliderScrollView {
    if (!_sliderScrollView) {
        _sliderScrollView = [[XTJSliderScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_WIDTH/16*9) WithNetImages:self.sliderImageArray];
        /** 设置滚动延时*/
        _sliderScrollView.autoScrollDelay = 3;
        /** 设置占位图 */
        _sliderScrollView.placeholderImage = [UIImage imageNamed:@"00001"];
        /** 获取网络图片的index*/
        _sliderScrollView.netDelagate = self;
    }
    return _sliderScrollView;
}



- (NSMutableArray *)itemBtnArray {
    if(!_itemBtnArray) {
        _itemBtnArray = [[NSMutableArray alloc]init];
    }
    return _itemBtnArray;
}


@end
