//
//  XTJConfirmAnOrderViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STConfirmAnOrderViewController.h"
#import "STConfirmAnOrderCell.h"
#import "STSelectAddressViewController.h"
#import "STGoodsModel.h"
#import "STConfirmAnOrderHeadView.h"
//#import "XTJManageAddressViewController.h"
//#import "XTJAddOrEditAddressViewController.h"
#import "STAddressModel.h"

@interface STConfirmAnOrderViewController ()<UITableViewDelegate,UITableViewDataSource,STConfirmAnOrderHeadViewDelegate,STConfirmAnOrderCellDelegate,selectAddressViewControllerDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) STConfirmAnOrderHeadView *headView;
@property (nonatomic,strong) STGoodsModel *goodsModel;
@property (nonatomic,strong) NSMutableArray *addressArray;

@property (nonatomic,weak) UILabel *priceLabel;

@property (nonatomic,strong) NSArray *goodsModels;
@end


@implementation STConfirmAnOrderViewController

- (id)initWithGoodsModel:(STGoodsModel *)goodsModel {
    
    self = [super init];
    if (self) {
        self.goodsModels = @[goodsModel];
    }
    return self;
}


- (instancetype)initWithGooddModels:(NSArray<STGoodsModel *> *)goodsModels {
    
    self = [super init];
    if (self) {
        self.goodsModels = goodsModels;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
//    [self setupData];
    
}

- (void)setupData {
    
    [MBProgressHUD showMessage:@"加载中.."];
    NSDictionary *parameters = @{
                                 @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                 };

    [[TJNetworking manager] post:kAddressListURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {


        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {

            self.addressArray = [STAddressModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            self.headView.addressModel = self.addressArray.firstObject;
//             self.headView.addressModel = nil;
        } else if ([response.responseObject[@"code"] isEqualToString:@"99"]) {
            [MBProgressHUD hideHUD];
            NSLog(@"无默认地址,添加默认地址");
             self.headView.addressModel = nil;

        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {


        [MBProgressHUD showSuccess:@"加载失败 请重试！"];
    } finished:^{

        [MBProgressHUD hideHUD];

    }];
}
- (void)loadNewData {
    
    [self.tableView.mj_header endRefreshing];
    [self setupData];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =  NSLocalizedString(@"confirmOrderController_title", @"确认订单");//@"确认订单";
    __weak typeof(self) weakSelf = self;

    UITableView *tableViiew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableViiew.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    tableViiew.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViiew.delegate  = self;
    tableViiew.dataSource  = self;
    [self.view addSubview:tableViiew];
    self.tableView = tableViiew;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.headView = [[STConfirmAnOrderHeadView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 100)];
    self.headView.delegate = self;
    self.headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView =self.headView;
    
    
    
    UIView *defrayBar = [[UIView alloc]init];
    defrayBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:defrayBar];
    [defrayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(iPhoneX?-34:0);
        make.height.equalTo(55);
    }];
    
    CGFloat price = 0.0;
    for (STGoodsModel *goodsModel in self.goodsModels) {
        price = price + [goodsModel.price floatValue];
    }
    NSString *priceString = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"addUp", @"合计"),[NSString stringWithFormat:@"%.2f",price]];
    UILabel *priceLabel = [UILabel XTJ_createWithTitle:priceString titleColor:[UIColor jk_colorWithHex:0xB70C0C] font:14 textAlignment:NSTextAlignmentLeft];
    priceLabel.backgroundColor = [UIColor clearColor];
    [defrayBar addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(defrayBar).offset(20);
        
    }];
    
    
    UIButton *defrayBtn = [[UIButton alloc] init];
    defrayBtn.backgroundColor = [UIColor jk_colorWithHex:0xB70C0C];
    defrayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [defrayBtn setTitle:NSLocalizedString(@"payment", @"立即支付" )forState:UIControlStateNormal];
    [defrayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [defrayBtn addTarget:self action:@selector(defrayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [defrayBar addSubview:defrayBtn];
    [defrayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(defrayBar);
        make.size.equalTo(CGSizeMake(100, 55));
    }];

}

- (void)defrayBtnClicked:(UIButton *)btn {
    
    [self alert];
   
}
// 确认购买
- (void)buyGoodsModel:(STGoodsModel *)goodsModel {
    
    //    “product_id”:”pd000001”,           //商品id，必传参数
    //    “user_id”:”cus15963215489”,        //用户id，必传参数
    //    “num”:”2”
    __weak typeof(self) weakSelf = self;
   // [MBProgressHUD showMessage:@""];
//    NSDictionary *parmaeters = @{  @"product_id":goodsModel.product_id,
//                                   @"user_id":[UsersManager sharedUsersManager].currentUser.user_id,
//                                   @"num":@"1"
//                                   };
//    [[TJNetworking manager] post:kCreateOrderURL parameters:parmaeters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
//        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
//            //            [MBProgressHUD showMessage:@"支付完成"];
////            [MBProgressHUD hideHUD];
////            [MBProgressHUD showSuccess:@"购买成功"];
//            [weakSelf deleteGoodsOnshoppingCarGoodsModel:goodsModel];
//
//        }
//
//    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
//        NSLog(@"%@",response.message);
//    } finished:^{
//        NSLog(@"完成");
//        [MBProgressHUD hideHUD];
//    }];
    
}

- (void)deleteGoodsOnshoppingCarGoodsModel:(STGoodsModel *)goodsModel  {
    
   
//    NSDictionary *parameters = @{@"product_id":goodsModel.product_id,
//                                 @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
//                                 };
//    
    
//    [[TJNetworking manager] post:kDeleteShoppingCartURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
//
//        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
////            [MBProgressHUD showSuccess:@"删除成功！"];
////            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"订单已生成！" message:@"可以去我的订单去查看订单状态！" preferredStyle:UIAlertControllerStyleAlert];
////            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////                [self deleteComplete];
////
////            }];
////
////            [alert addAction:action];
////
////            [self presentViewController:alert animated:YES completion:nil];
////            [self performSelector:@selector(deleteComplete) withObject:self afterDelay:1];
//        }
//    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
//
//    } finished:^{
//
//    }];
}
-  (void)deleteComplete {
    
    [MBProgressHUD hideHUD];
    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"订单已生成！" message:@"可以去我的订单去查看订单状态！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alert1 addAction:action1];
    
    [self presentViewController:alert1 animated:YES completion:nil];
   
}

- (void)alert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示！" message:@"为确保您的资金安全，本商城暂不支持网络支付，已选择货到付款" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"10086"];
//
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        for (STGoodsModel *goodsModel in self.goodsModels) {
            [self buyGoodsModel:goodsModel];
        }
//        [self buy];
        [MBProgressHUD showMessage:@""];
        [self performSelector:@selector(deleteComplete) withObject:self afterDelay:2];
       

      
    }];
//    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:<#@"删除"#> style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
    
    [alert addAction:action];
    [alert addAction:action1];
//    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)defrayBtnClicked {
    
    
}

#pragma mark -------------------------- selectAddressViewControllerDelegate ----------------------------------------

- (void)selectAddressViewController:(STSelectAddressViewController *)selectAddressVC address:(STAddressModel *)addressModel {
    
    self.headView.addressModel = addressModel;
}
#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *  confirmAnOrderCellIdentifier = @"confirmAnOrderCellIdentifier";
    STConfirmAnOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmAnOrderCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"STConfirmAnOrderCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.goodsModel = self.goodsModels[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

#pragma mark -------------------------- XTJConfirmAnOrderHeadViewDelegate ----------------------------------------

- (void)confirmAnOrderHeadView:(STConfirmAnOrderHeadView *)headView didSelectAddress:(UITapGestureRecognizer *)tap {
    
    STSelectAddressViewController *selectAddressVC = [[STSelectAddressViewController alloc]init];
    selectAddressVC.delegate = self;
    [self.navigationController pushViewController:selectAddressVC animated:YES];
    
}

- (void)confirmAnOrderHeadView:(STConfirmAnOrderHeadView *)headView didAddAddress:(UIButton *)btn {
    
//    XTJAddOrEditAddressViewController *addOrEditAddressVC = [[XTJAddOrEditAddressViewController alloc]initWithType:AddOrEditAddressViewControllerTypeAdd];
//    [self.navigationController pushViewController:addOrEditAddressVC animated:YES];
    
}
#pragma mark -------------------------- XTJConfirmAnOrderCellDelegate ----------------------------------------
- (void)confirmAnOrderCell:(STConfirmAnOrderCell *)confirmAnOrderCell didCChangeAmount:(NSInteger)amout {
    
    self.priceLabel.text = [NSString stringWithFormat:@"合计:%.2f",amout * [self.goodsModel.price floatValue]];
}


@end
