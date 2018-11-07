//
//  STHomeViewController.m
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STHomeViewController.h"
#import "STHomeHeadView.h"
#import "STGoodsModel.h"
#import "STBannerModel.h"
#import "STHomeCategoryBtnModel.h"
#import "STPersonalMessageViewController.h"
#import "STCollectionViewCell.h"
#import "STGoodsInfoViewController.h"
#import "STGoodsCategoryViewController.h"
#import "STHomeCollectionTitleView.h"
//#import <TJWebTools/TJWebTools.h>
#import "STSearchContainerViewController.h"
#import "TNGWebViewController.h"

@interface STHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,STCollectionViewCellDelegate,STHomeHeadViewDelegate,UISearchBarDelegate>

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *goodsArray;
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *bannerArray;
@property (nonatomic,weak) STHomeHeadView *headView;
@property (nonatomic,strong) UIView *tapView;
@end

static NSString *code = @"1";
static NSString *collectionViewCellIdentifier = @"collectionViewCell";
static NSString *collectionViewHeadIdentifier = @"collectionViewHead";
static NSString *collectionViewTitleIdentifier = @"collectionVieTitle";
@implementation STHomeViewController

- (void)setupData1 {


    //    NSDictionary *dic = @{@"appId":@"tj2_20180720008"};
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc]init];
    [httpManager GET:@"http://45.63.35.70:8080/common_tj/start_page/DelicacyMall" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;

        if ([dic[@"code"] isEqualToString:@"1"]) {

            [[NSUserDefaults standardUserDefaults] setObject:dic[@"msg"] forKey:@"msg"];
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"code"] forKey:@"code"];


        }
        if ([dic[@"code"] isEqualToString:@"0"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"msg"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"code"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"code"] isEqualToString:code]) {
        TNGWebViewController *NAV_VC = [[TNGWebViewController alloc]init];
        NSString *urlstring =  [[NSUserDefaults standardUserDefaults] objectForKey:@"msg"];
        [NAV_VC loadWebURLSring:urlstring];
        [self presentViewController:NAV_VC animated:NO completion:nil];
    }
    [self setupData1];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //        [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    //    [self.collectionView.mj_header beginRefreshing];
    
    //        [MBProgressHUD showMessage:@"加载中.."];
}

- (void)setupData {
    
    [self.collectionView.mj_header endRefreshing];
    __weak typeof(self) weakSelf = self;
    
//    [MBProgressHUD showMessage:[NSString TJ_localizableZHNsstring:@"加载中.." enString:@"loading..."]];
    
    [[UIApplication sharedApplication] jk_beganNetworkActivity];
    // 商品
    [[TJNetworking manager] get:kHomeListProductURL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            [MBProgressHUD hideHUD];
            weakSelf.goodsArray = [STGoodsModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [weakSelf.collectionView reloadData];
        }else  {
            
            
        }
        
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        [MBProgressHUD hideHUD];
        
    } finished:^{
        
        [MBProgressHUD hideHUD];
    }];
    
    //banner
    [[TJNetworking manager] get:kHomeBannerURL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            
            weakSelf.bannerArray = [STBannerModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [weakSelf.headView setBanner:weakSelf.bannerArray];
//                        [weakSelf.collectionView reloadData];
        }
        
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    // 分类
    [[TJNetworking manager] get:kHomeCategoryURL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            
            weakSelf.categoryArray = [STHomeCategoryBtnModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [weakSelf.headView setCategoryBtn:weakSelf.categoryArray];
            //            [weakSelf.collectionView reloadData];
        }
        
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
    
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Tabar_Home_Title", @"首页");//@"首页";
    
    UISearchBar *searchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    searchBar.delegate = self;
    //    searchBar.barStyle =  UIBarStyleBlack;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar = searchBar;
    self.navigationItem.titleView  = self.searchBar;
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    UIImage *rightImage = [UIImage imageNamed:@"铃铛 消息"];
    rightImage = [rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(rightButton:)];
    
    //    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.headerReferenceSize = CGSizeMake(DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_WIDTH/16*9 + 154);
    layout.itemSize = CGSizeMake((DEVICE_SCREEN_WIDTH - 10)/2,DEVICE_SCREEN_WIDTH/2/3*4);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    collectionView.delegate  = self;
    collectionView.dataSource = self;
    collectionView.emptyDataSetDelegate = self;
    collectionView.emptyDataSetSource  = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //    [self.collectionView registerClass:[XTJCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"STCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    [self.collectionView registerClass:[STHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:collectionViewHeadIdentifier];
    [self.collectionView registerClass:[STHomeCollectionTitleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:collectionViewTitleIdentifier];
    
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
         [self.collectionView.mj_header beginRefreshing];
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//
//    STSearchContainerViewController *VC = [[STSearchContainerViewController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
//    return NO;
//}

- (void)rightButton:(id)sender  {
    
    STPersonalMessageViewController *messageVC = [[STPersonalMessageViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}


- (void)loadNewData {
    
    [self setupData];
    
}


#pragma mark -------------------------- searchBar delegate ----------------------------------------
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    TJLog(@"结束编辑");
    
   
    
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    TJLog(@"开始编辑");
    
    [self.view addSubview:self.tapView];

    return YES;
}
- (void)tap:(UITapGestureRecognizer* )tap {
    TJLog(@"取消第一响应者");
    [self.tapView removeFromSuperview];
    [self.searchBar resignFirstResponder];
    
}

#pragma mark -------------------------- collectionView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    STCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    cell.delagate = self;
    //    cell.backgroundColor = [UIColor redColor];
    cell.goodsModel = self.goodsArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
   
   
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
             STHomeHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeadIdentifier forIndexPath:indexPath];
            headView.delegate = self;
            self.headView = headView;
            return headView;
        }else {
             STHomeCollectionTitleView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewTitleIdentifier forIndexPath:indexPath];
            return titleView;
            
        }
       
    }
    
    return nil;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
   
    if (section == 0) {
        return CGSizeMake(DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_WIDTH/16*9 + 204);
    }else {
        
        return CGSizeMake(DEVICE_SCREEN_WIDTH, 60);
    }
}






- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    STGoodsInfoViewController *goodsInfoVC = [[STGoodsInfoViewController alloc]initWithGooddModel:self.goodsArray[indexPath.row]];
    [self.navigationController pushViewController:goodsInfoVC animated:YES];
}



#pragma mark -------------------------- STcollectionViewcell delegate ----------------------------------------
- (void)collectionViewCell:(STCollectionViewCell *)cell didBuyNoe:(UIButton *)buyNoeBtn {
    
}


#pragma mark -------------------------- XTJHomeHeadView delegate ----------------------------------------
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectedMoreBtn:(UIButton *)moreBtn {
    //    XTJGoodsInfoViewController *goodsInfoVC = [XTJGoodsInfoViewController alloc]initWithGooddModel:<#(XTJGoodsModel *)#>
    
}
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectBannerAtIndex:(NSInteger)index {
    
}
- (void)homeHeadView:(STHomeHeadView *)homeHeadView didSelectCategoryBtnAtIndex:(NSInteger)index {
    
    STGoodsCategoryViewController *goodsCategoryVC = [[STGoodsCategoryViewController alloc]initWithCategoryBtnModel:self.categoryArray[index]];
    [self.navigationController pushViewController:goodsCategoryVC animated:YES];
    
    
}

///** 每个cell的尺寸*/
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(60, 60);
//}

#pragma mark -------------------------- DZNEmptyDataSetDelegate ----------------------------------------
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *string = @"请重试！";
    NSMutableAttributedString *mbString = [[NSMutableAttributedString alloc]initWithString:string];
    return mbString;
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    [self.collectionView.mj_header beginRefreshing];
}



#pragma mark -------------------------- lazy load ----------------------------------------
- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [[UIView alloc]initWithFrame:self.view.frame];
        _tapView.backgroundColor  = [UIColor blackColor];
        _tapView.alpha = 0.5;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_tapView addGestureRecognizer:tapGesture];
    }
    return _tapView;
}
@end
