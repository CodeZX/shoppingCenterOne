//
//  STPersonalMessageViewController.m
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STPersonalMessageViewController.h"
#import "STGoodsModel.h"
#import "XTJMyCollectionGoodsCell.h"
@interface STPersonalMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *goodsModelArray;
@end

@implementation STPersonalMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource  = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    tableView.separatorInset = UIEdgeInsetsMake(30, 30, 0, 30);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    [MBProgressHUD showMessage:@"加载中.."];
    NSDictionary *parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id};
    [[TJNetworking manager] post:kGoodsCollectURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            self.goodsModelArray = [STGoodsModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [self.tableView reloadData];
        } else if ([response.responseObject[@"code"] isEqualToString:@"99"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"没有收藏的产品"];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark -------------------------- UITableViewDelegate ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.goodsModelArray.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"XTJMyCollectionGoodsCell";
    XTJMyCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //        cell = [[XTJMyCollectionGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XTJMyCollectionGoodsCell" owner:nil options:nil] lastObject];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    cell.goodsModel = self.goodsModelArray[indexPath.row];
    //    cell.contentView.backgroundColor = RandomColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    STGoodsModel *goodsModel = self.goodsModelArray[indexPath.row];
    NSDictionary *parameters = @{@"product_id":goodsModel.product_id,
                                 @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                 };
    
    
    [[TJNetworking manager] post:kDeleteCollectURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:@"删除成功！"];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
    [self.goodsModelArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//
//    NSString *title = @"没有数据！";
//
//    NSAttributedString *abString = [[NSAttributedString alloc]initWithString:title attributes:@{
//                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
//                                NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
//    return abString;
//}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *title = @"暂无消息";
    
    NSAttributedString *abString = [[NSAttributedString alloc]initWithString:title attributes:@{
                                                                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                                                                                NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    return abString;
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    [self.tableView.mj_header beginRefreshing];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
