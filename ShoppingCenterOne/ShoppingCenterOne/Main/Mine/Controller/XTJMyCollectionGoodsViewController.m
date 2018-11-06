//
//  XTJMyCollectionGoodsViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//    商品

#import "XTJMyCollectionGoodsViewController.h"
#import "XTJMyCollectionGoodsCell.h"
#import "STGoodsModel.h"
#import "STGoodsInfoViewController.h"

@interface XTJMyCollectionGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *goodsModelArray;
@end

@implementation XTJMyCollectionGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect;
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = DEVICE_SCREEN_WIDTH;
    rect.size.height = DEVICE_SCREEN_HEIGHT;
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
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
    
    [MBProgressHUD showMessage:[NSString TJ_localizableZHNsstring:@"加载中.." enString:@"Loading.."]];
    NSDictionary *parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id};
    [[TJNetworking manager] post:kGoodsCollectURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            self.goodsModelArray = [STGoodsModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
            [self.tableView reloadData];
        } else if ([response.responseObject[@"code"] isEqualToString:@"99"]) {
             [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"没有收藏的产品" enString:@"No collection of products"]];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark -------------------------- UITableViewDelegate ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsModelArray.count;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STGoodsInfoViewController *goodsInfoVC = [[STGoodsInfoViewController alloc]initWithGooddModel:self.goodsModelArray[indexPath.row]];
    [self.navigationController pushViewController:goodsInfoVC animated:YES];
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
            [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"删除成功！" enString:@"successfully deleted!"]];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
    [self.goodsModelArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
   
}


#pragma mark -------------------------- DZNEmptyDataSetDelegate ----------------------------------------
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *string = [NSString TJ_localizableZHNsstring:@"没有收藏的商品" enString:@"没有收藏的商品"];
    NSAttributedString  *mbString = [[NSAttributedString alloc]initWithString:string];
    return mbString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
