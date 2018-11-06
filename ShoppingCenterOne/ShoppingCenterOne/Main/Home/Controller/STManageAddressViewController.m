//
//  XTJManageAddressViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STManageAddressViewController.h"
#import "STManageAddressCell.h"
#import "STAddOrEditAddressViewController.h"

#import "STSelectAddressViewController.h"
#import "STAddressModel.h"

@interface STManageAddressViewController ()<UITableViewDelegate,UITableViewDataSource,STManageAddressCellDeleDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *addressArray;
@end

@implementation STManageAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}



- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"manageController_title", @"管理收货地址");//@"管理收货地址";
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(manageAddressBtnClick:)];
    UITableView *tableViiew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableViiew.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    tableViiew.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViiew.delegate  = self;
    tableViiew.dataSource  = self;
    [self.view addSubview:tableViiew];
    self.tableView = tableViiew;
    self.tableView.mj_header  =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 100)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView  = footView;
    
    UIButton *addBtn = [[UIButton alloc]init];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.size.equalTo(CGSizeMake(200, 30));
    }];
}

- (void)loadNewData {
    
    [self.tableView.mj_header endRefreshing];
    [self setupData];
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

- (void)addBtnClick:(UIButton *)btn {
    
    STAddOrEditAddressViewController *editAddressVC = [[STAddOrEditAddressViewController alloc]initWithType:AddOrEditAddressViewControllerTypeAdd];
    [self.navigationController pushViewController:editAddressVC animated:YES];
    

}

#pragma mark -------------------------- tableView delegate ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *  manageAddressCellIdentifier = @"XTJManageAddressCell";
    STManageAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:manageAddressCellIdentifier];
    if (!cell) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"STManageAddressCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.addressModel = self.addressArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 124;
}

#pragma mark -------------------------- XTJManageAddressCellDeleDelegate ----------------------------------------

- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didSelectDefaultAddress:(STAddressModel *)addressMdoel {
    
    [MBProgressHUD showSuccess:@"服务器偷懒了,请重试一下！"];
}

- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didEditAddress:(STAddressModel *)addressMdoel {
    [MBProgressHUD showSuccess:@"服务器偷懒了,请重试一下！"];
    
}

- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didDeleteAddress:(STAddressModel *)addressMdoel {
    
//   [MBProgressHUD showSuccess:@"服务器偷懒了,请重试一下！"];
    [MBProgressHUD showSuccess:@"删除中.."];
    NSDictionary *parameters  = @{@"address_id":addressMdoel.address_id};
    [[TJNetworking manager] post:kDeleteAddressURL parameters:parameters  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
         if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
             
             [self.tableView.mj_header beginRefreshing];
             [MBProgressHUD hideHUD];
             [MBProgressHUD showSuccess:@"删除成功！"];
         }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        [MBProgressHUD hideHUD];
    }];
    
}

@end
