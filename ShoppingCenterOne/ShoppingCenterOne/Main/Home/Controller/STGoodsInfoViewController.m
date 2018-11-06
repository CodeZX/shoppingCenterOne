//
//  XTJGoodsInfoViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STGoodsInfoViewController.h"

#import "XTJSliderScrollView.h"
#import "STGoodsDetailsView.h"
#import "STGoodsToolBar.h"
#import "STGoodsSizeSelectView.h"
#import "STGoodsParameterView.h"
#import "STConfirmAnOrderViewController.h"
#import "XTJShoppingCartViewController.h"

#import "STGoodsModel.h"
@interface STGoodsInfoViewController ()<SliderScrollViewNetDelegate,STGoodsToolBarDelegate,UIScrollViewDelegate,STGoodsDetailsViewDelegate>


@property (nonatomic,strong) NSArray *sliderImageArray;
@property (nonatomic,weak) STGoodsDetailsView *goodsDetailsView;
@property (nonatomic,weak) STGoodsToolBar *goodsToolBar;

@property (nonatomic,strong) STGoodsModel *goodsModel;

@end

@implementation STGoodsInfoViewController

- (instancetype)initWithGooddModel:(STGoodsModel *)goodsModel {
    
    if (!goodsModel) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.goodsModel = goodsModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}


- (void)setupData {
    
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"zxzxzxzx%f",self.view.safeAreaInsets.bottom);
//    } else {
//        // Fallback on earlier versions
//    }
//    [self.goodsToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.safeAreaInsets.bottom);
//    }];
//    NSLog(@"\n\\nn\n\n%f", self.goodsDetailsView.contentOffset.y);
//    NSLog(@"\n\\nn\n\n%f", self.goodsDetailsView.adjustedContentInset.top);
//    self.goodsDetailsView.alwaysBounceHorizontal = YES;
    
   
   
}



- (void)setupUI {
    
    self.title = NSLocalizedString(@"goodsdetailsController_title", @"商品详情"); //@"商品详情";
    self.view.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    __weak typeof(self) weakSelf = self;
    

    
    STGoodsDetailsView *goodsDetailsView = [[STGoodsDetailsView alloc]initWithGoodsModel:self.goodsModel];
    goodsDetailsView.delegate = self;
    [self.view addSubview:goodsDetailsView];
    self.goodsDetailsView = goodsDetailsView;
    [self.goodsDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.bottom).offset(iPhoneX ? -34:0);
    }];
    
    
    STGoodsToolBar *goodsToolBar = [[STGoodsToolBar alloc]init];
//    goodsToolBar.backgroundColor =[UIColor redColor];
    goodsToolBar.delegate = self;
    [self.view addSubview:goodsToolBar];
    self.goodsToolBar = goodsToolBar;
    [self.goodsToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.bottom).offset(iPhoneX ? -34:0);
        make.height.equalTo(44);
    }];
    
    

    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect_pre"] forState:UIControlStateSelected];
    [collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectBtn];
    
    
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
//    [shareBtn setImage:[UIImage imageNamed:@"icon_collect_pre"] forState:UIControlStateSelected];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItems = @[collectItem,shareItem];
    
}



- (void)collectBtnClick:(UIButton *)btn {
    
    if ([UsersManager sharedUsersManager].currentUser) {
        btn.selected = !btn.selected;

        if (btn.selected) {
            NSDictionary *parameters = @{@"product_id":self.goodsModel.product_id,
                                         @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                         };
            [[TJNetworking manager] post:kGoodsAddToCollectURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
                if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
                    [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"收藏成功！" enString:@"Favorite"]];
                }
            } failed:^(TJNetworkingFailureResponse * _Nonnull response) {

            } finished:^{

            }];
        }
    }else {

        [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请先登录！" enString:@"please log in first"]];
    }

    
    
}

- (void)shareBtnClick:(UIButton *)btn {
    
    
    //分享的标题
    NSString *textToShare = self.goodsModel.name;
    //分享的图片
    
    UIImage *imageToShare = [UIImage  imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.goodsModel.product_pic]]];
    //分享的url
    //    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
    
    
}
#pragma mark -------------------------- XTJGoodsDetailsViewDelegate ----------------------------------------
- (void)selectSizeForGoodsDetailsView:(STGoodsDetailsView *)goodsDetailsView {
    
//    XTJGoodsSizeSelectView *sizeSelectView = [[XTJGoodsSizeSelectView alloc]initWithFrame:CGRectMake(0, DEVICE_SCREEN_HEIGHT, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT)];
    STGoodsSizeSelectView *sizeSelectView = [[STGoodsSizeSelectView alloc]initWithFrame:CGRectMake(0, DEVICE_SCREEN_HEIGHT, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT) goodsModel:self.goodsModel];
    [self.view addSubview:sizeSelectView];
    
    [UIView animateWithDuration:.5 animations:^{
        
        sizeSelectView.frame = CGRectMake(0, DEVICE_SCREEN_HEIGHT * 0.3, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
    }];
    
}

- (void)selectParameterForGoodsDetailsView:(STGoodsDetailsView *)goodsDetailsView {
    
    STGoodsParameterView *parameterView = [[STGoodsParameterView alloc]initWithFrame:CGRectMake(0, DEVICE_SCREEN_HEIGHT, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * 0.3) goodsModel:self.goodsModel];
    [self.view addSubview:parameterView];
    
    [UIView animateWithDuration:.5 animations:^{
        
        parameterView.frame = CGRectMake(0, DEVICE_SCREEN_HEIGHT * 0.7, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT * 0.3);
    }];
}

#pragma mark -------------------------- UIScrollViewDelegate ----------------------------------------

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    if (scrollView.contentOffset.y > 50) {
//
//        CGFloat H = self.goodsDetailsView.frame.size.height;
//        CGFloat W = self.goodsDetailsView.frame.size.width;
//        CGFloat X = self.goodsDetailsView.frame.origin.x;
//        CGFloat Y = self.goodsDetailsView.frame.origin.y - scrollView.contentOffset.y;
//        if (Y < 300) {
//            Y = 300;
//        }
//        self.goodsDetailsView.frame = CGRectMake(X, Y, W, H);
//    }
//
//    if (scrollView.contentOffset.y < -100) {
//
//        CGFloat H = self.goodsDetailsView.frame.size.height;
//        CGFloat W = self.goodsDetailsView.frame.size.width;
//        CGFloat X = self.goodsDetailsView.frame.origin.x;
//        CGFloat Y = self.goodsDetailsView.frame.origin.y - scrollView.contentOffset.y;
//        if (Y > DEVICE_SCREEN_HEIGHT * 0.5) {
//            Y = DEVICE_SCREEN_HEIGHT * 0.5;
//        }
//        self.goodsDetailsView.frame = CGRectMake(X, Y, W, H);
//    }
//}

#pragma mark --------------------------  XTJGoodsToolBarDelegate ----------------------------------------
- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickStoreBtn:(UIButton *)storeBtn {
    
           NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"021-52716511"];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
     
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else {
        
        [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"暂不能拨打电话，请稍后重试！" enString:@"Can't call now, please try again later!"]];
    }
}

- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickShoppingCartBtn:(UIButton *)shoppingCartBtn {
    
    XTJShoppingCartViewController *shoppingCarVC = [[XTJShoppingCartViewController alloc]init];
    [self.navigationController pushViewController:shoppingCarVC animated:YES];
}


- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickBuyNowBtn:(UIButton *)BuyNowBtn {
    
    if ([UsersManager sharedUsersManager].currentUser) {

        STConfirmAnOrderViewController *confirmAnOrderVC = [[STConfirmAnOrderViewController alloc]initWithGoodsModel:self.goodsModel];
        [self.navigationController pushViewController:confirmAnOrderVC animated:YES];
    }else {

         [MBProgressHUD showSuccess:[NSString  TJ_localizableZHNsstring:@"请先登录！" enString:@"please log in first"]];
    }
    
    
   
}

- (void)goodsToolBar:(STGoodsToolBar *)goodsTollBar didClickaddToShoppingCartBtn:(UIButton *)BuyNowBtn {
    
   
    if ([UsersManager sharedUsersManager].currentUser) {
        NSDictionary *parameters = @{@"product_id":self.goodsModel.product_id,
                                     @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                     };
        [[TJNetworking manager] post:kAddToShoppingCartURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
            
            if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"加入成功" enString:@"Joined successfully"]];
            }
        } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
            
        } finished:^{
            
        }];
    }else {
        
        [MBProgressHUD showSuccess:[NSString  TJ_localizableZHNsstring:@"请先登录！" enString:@"please log in first"]];
    }
   
}




@end

