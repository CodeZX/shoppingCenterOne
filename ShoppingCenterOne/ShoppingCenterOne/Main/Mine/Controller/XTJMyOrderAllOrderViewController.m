//
//  XTJMyOrderAllOrderViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
// 全部订单

#import "XTJMyOrderAllOrderViewController.h"
#import "XTJMyOrderCell.h"
#import "XTJOrderModel.h"
#import "STGoodsInfoViewController.h"
#import "STGoodsModel.h"
#import "STConfirmAnOrderViewController.h"
@interface XTJMyOrderAllOrderViewController ()<UITableViewDataSource,UITableViewDelegate,myOrderCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *orderModelArray;
@end

@implementation XTJMyOrderAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource  = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)loadNewData {
    
    [self.tableView.mj_header endRefreshing];
    [self setupData];
}

- (void)setupData {
//
    [MBProgressHUD showMessage:[NSString TJ_localizableZHNsstring:@"加载中.." enString:@"Loading.."]];
    NSDictionary *parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id};
    [[TJNetworking manager] post:kAllOrderURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
    
        if ([response.responseObject[@"code"] isEqualToString:@"0"]){
            self.orderModelArray = [XTJOrderModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [self.tableView reloadData];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark -------------------------- UITableViewDelegate ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    XTJMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
//        cell = [[XTJMyOrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XTJMyOrderCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    cell.orderModer = self.orderModelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 242;
}

#pragma mark -------------------------- myOrderCellDelegate ----------------------------------------

- (void)myOrderCell:(XTJMyOrderCell *)myOrderCell didAction:(XTJOrderModel *)orderModel {
    
//    XTJGoodsModel *goodsModel = [[XTJGoodsModel alloc]init];
//    goodsModel.product_id =
//    XTJConfirmAnOrderViewController *confirmAnOrderVC =[[XTJConfirmAnOrderViewController alloc]initWithGoodsModel:self.goodsModel];
//    [self.navigationController pushViewController:confirmAnOrderVC animated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString TJ_localizableZHNsstring:@"提示!" enString:@"prompt!"] message:[NSString TJ_localizableZHNsstring:@"为确保您的资金安全，本商城暂不支持网络支付，默认选择货到付款" enString:@"To ensure the security of your funds, this mall does not support online payment, the default is to choose cash on delivery"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString TJ_localizableZHNsstring:@"取消" enString:@"cancel"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:[NSString TJ_localizableZHNsstring:@"拨打卖家电话" enString:@"Call the seller's phone number"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"021-52716511"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
    }];
    //    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:<#@"删除"#> style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //
    //    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    //    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
