//
//  XTJGoodsCategoryViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/30.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsCategoryViewController.h"
#import "STCollectionViewCell.h"
#import "STGoodsModel.h"
#import "STGoodsInfoViewController.h"
#import "STHomeCategoryBtnModel.h"
#import "STConfirmAnOrderHeadView.h"



static NSString *goodsCategoryCellIdentifier = @"collectionViewCell";
@interface STGoodsCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,STCollectionViewCellDelegate>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *goodsArray;
@property (nonatomic,strong) STHomeCategoryBtnModel *categoryBtnModel;

@end

@implementation STGoodsCategoryViewController

- (instancetype)initWithCategoryBtnModel:(STHomeCategoryBtnModel *)categoryBtnModel {
    self = [super init];
    if (self) {
        self.categoryBtnModel = categoryBtnModel;
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if ([currentLanguage isEqualToString:@"en-US"] || [currentLanguage isEqualToString:@"en"]) {
            self.title = @"category";
        }else {
            self.title = categoryBtnModel.category;
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
}


- (void)setupData{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters  = @{@"category":self.categoryBtnModel.category };

    [[TJNetworking manager] post:kCategoryGoodsURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            
            weakSelf.goodsArray = [STGoodsModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [weakSelf.collectionView reloadData];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
    
}
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.headerReferenceSize = CGSizeMake(DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_WIDTH/16*9 + 154);
    layout.itemSize = CGSizeMake((DEVICE_SCREEN_WIDTH - 10)/2,DEVICE_SCREEN_WIDTH/2/3*4);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor jk_colorWithHex:0xF2F2F2];
    collectionView.delegate  = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //    [self.collectionView registerClass:[XTJCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"STCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:goodsCategoryCellIdentifier];
//    [self.collectionView registerClass:[XTJHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:collectionViewHeadIdentifier];
}


#pragma mark -------------------------- collectionView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    STCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:goodsCategoryCellIdentifier forIndexPath:indexPath];
    cell.delagate = self;
    //    cell.backgroundColor = [UIColor redColor];
    cell.goodsModel = self.goodsArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    STGoodsInfoViewController *goodsCategoryVC = [[STGoodsInfoViewController alloc]initWithGooddModel:self.goodsArray[indexPath.row]];
    
    [self.navigationController pushViewController:goodsCategoryVC animated:YES];
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    XTJHomeHeadView *headView = nil;
//
//    if (kind == UICollectionElementKindSectionHeader){
//
//        headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeadIdentifier forIndexPath:indexPath];
//        headView.delegate = self;
//        self.headView = headView;
//    }
//    return headView;
//
//}



@end
