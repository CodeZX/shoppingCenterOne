//
//  XTJMyOrderPendingReceiptViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
// 待收货

#import "XTJMyOrderPendingReceiptViewController.h"
#import "XTJMyOrderCell.h"
#import "XTJOrderModel.h"

@interface XTJMyOrderPendingReceiptViewController ()<UITableViewDataSource,UITableViewDelegate,myOrderCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *orderModelArray;
@end

@implementation XTJMyOrderPendingReceiptViewController

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
            
           NSArray *array = [XTJOrderModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            for (XTJOrderModel *model in array) {
                if ([model.type isEqualToString:@"1"]) {
                    [self.orderModelArray addObject:model];
                }
            }
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
    
    
}

@end
