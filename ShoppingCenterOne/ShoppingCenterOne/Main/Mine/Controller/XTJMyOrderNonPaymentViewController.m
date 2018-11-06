//
//  XTJMyOrderNonPaymentViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
// 未付款

#import "XTJMyOrderNonPaymentViewController.h"
#import "XTJMyOrderCell.h"
#import "XTJOrderModel.h"

@interface XTJMyOrderNonPaymentViewController ()<UITableViewDataSource,UITableViewDelegate,myOrderCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *orderModelArray;
@end

@implementation XTJMyOrderNonPaymentViewController

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
    [MBProgressHUD showMessage:@"加载中.."];
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
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示！" message:@"为确保您的资金安全，本商城暂不支持网络支付，可选择货到付款" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拨打卖家电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"10086"];
        
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
