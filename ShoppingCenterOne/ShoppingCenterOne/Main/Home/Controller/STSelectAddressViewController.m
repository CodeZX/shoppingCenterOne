//
//  XTJSelectAddressViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STSelectAddressViewController.h"
#import "STSelectAddressCell.h"
#import "STManageAddressViewController.h"
#import "STAddressModel.h"

@interface STSelectAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *addressArray;
@end

@implementation STSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [self setupData];
}


- (void)setupData {
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showMessage:@"加载中.."];
    NSDictionary *parameters = @{
                                 @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                 };
    [[TJNetworking manager] post:kAddressListURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            self.addressArray = [STAddressModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [weakSelf.tableView reloadData];
            NSLog(@"请求成功");
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
        [MBProgressHUD hideHUD];
    }];
}
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"selectAddressController_title", @"选择收货地址");//@"选择收货地址";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"manage", @"管理") style:UIBarButtonItemStylePlain target:self action:@selector(manageAddressBtnClick:)];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    UITableView *tableViiew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableViiew.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    tableViiew.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViiew.delegate  = self;
    tableViiew.dataSource  = self;
    [self.view addSubview:tableViiew];
    self.tableView = tableViiew;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}


- (void)loadNewData {
    
    [self.tableView.mj_header endRefreshing];
    [self setupData];
}

- (void)manageAddressBtnClick:(UIButton *)btn {
    
    STManageAddressViewController *manageAddressVC = [[STManageAddressViewController alloc]init];
    [self.navigationController pushViewController:manageAddressVC animated:YES];
}
#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *  selectAddressIdentifier = @"XTJSelectAddressViewController";
    STSelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:selectAddressIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"STSelectAddressCell" owner:nil options:nil] lastObject];
    }
//    cell.addressModel = self.addressArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(selectAddressViewController:address:)]) {
        [self.delegate selectAddressViewController:self address:self.addressArray[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
