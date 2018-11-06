//
//  XTJShoppingCartViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/7/25.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJShoppingCartViewController.h"
#import "XTJShoppingCartTableViewCell.h"
#import "STGoodsInfoViewController.h"
#import "XTJGoodsModel.h"
#import "STConfirmAnOrderViewController.h"
#import "XTJLoginViewController.h"
#import "STBasicNavigationController.h"
#import "XTJAggregateBar.h"


@interface XTJShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,XTJAggregateBarDelegate,shoppingCartTableViewCellDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *goodsModelArray;

@property (nonatomic,weak) XTJAggregateBar *aggregateBar;
@end

@implementation XTJShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
     [self.tableView.mj_header beginRefreshing];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title =  NSLocalizedString(@"Tabar_shoppingCart_Title", @"购物车");//@"购物车";
    __weak typeof(self) weakSelf = self;
    
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
   
    
    XTJAggregateBar *aggregateBar = [XTJAggregateBar aggregateBar];
    aggregateBar.delegate = self;
//    aggregateBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:aggregateBar];
    self.aggregateBar = aggregateBar;
    if (self.tabBarController.tabBar.hidden) {
        [self.aggregateBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(iPhoneX?-39:0);
            make.left.right.equalTo(weakSelf.view);
            make.height.equalTo(50);
        }];
    } else {
        [self.aggregateBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(iPhoneX?-83:-44);
            make.left.right.equalTo(weakSelf.view);
            make.height.equalTo(50);
        }];
    }
    
    
}

- (void)loadNewData {
    
    [self.tableView.mj_header endRefreshing];
    if ([UsersManager sharedUsersManager].currentUser) {
         [self setupData];
    }else  {
        
        [self.tableView reloadData];
    }
   
}


- (void)setupData {

    [MBProgressHUD showMessage:[NSString TJ_localizableZHNsstring:@"加载中.." enString:@"Loading.."]];
    NSDictionary *parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id};
    
    [[TJNetworking manager] post:kShoppingCartURL parameters:parameters progress:nil
     success:^(TJNetworkingSuccessResponse * _Nonnull response) {
         [MBProgressHUD hideHUD];
         if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
             self.goodsModelArray = [XTJGoodsModel mj_objectArrayWithKeyValuesArray:response.responseObject[@"retData"]];
             [self.tableView reloadData];
             [self.aggregateBar setcheckAllBtnSelect:NO];
             
         }else  if([response.responseObject[@"code"] isEqualToString:@"99"] ){
             
             
             [self.goodsModelArray removeAllObjects];
             [self.tableView reloadData];
             [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"购物车为空" enString:@"Shopping cart is empty"]];
             [self.aggregateBar setcheckAllBtnSelect:NO];
             
         }
        
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"加载失败.." enString:@"Failed to load.."]];
    } finished:^{
        
        [MBProgressHUD hideHUD];
        [self.aggregateBar setcheckAllBtnSelect:NO];
    }];
}
#pragma mark -------------------------- tableView delegate ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsModelArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"XTJShoppingCartTableViewCell";
    XTJShoppingCartTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
//        cell = [[XTJShoppingCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XTJShoppingCartTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.goodsMdoel = self.goodsModelArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XTJConfirmAnOrderViewController *confirmAnOrderVC = [[XTJConfirmAnOrderViewController alloc]initWithGoodsModel:self.goodsModelArray[indexPath.row]];
//    [self.navigationController pushViewController:confirmAnOrderVC animated:YES];
    
    STGoodsInfoViewController *infoVC = [[STGoodsInfoViewController alloc]initWithGooddModel:self.goodsModelArray[indexPath.row]];
    [self.navigationController pushViewController:infoVC animated:YES];
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return YES;
//}
//
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return @"删除";
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XTJGoodsModel *goodsModel = self.goodsModelArray[indexPath.row];
    NSDictionary *parameters = @{@"product_id":goodsModel.product_id,
                                 @"user_id":[UsersManager sharedUsersManager].currentUser.user_id
                                 };
    
    
    [[TJNetworking manager] post:kDeleteShoppingCartURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"删除成功！" enString:@"successfully deleted!"]];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
    [self.goodsModelArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark -------------------------- shoppingCartTableViewCellDelegate ----------------------------------------

- (void)shoppingCartTableViewCell:(XTJShoppingCartTableViewCell *)shoppingCartTableViewCell didSelectedGooods:(XTJGoodsModel *)goodsModel {
    
    [self.aggregateBar addPriceAndCount:goodsModel];
}

- (void)shoppingCartTableViewCell:(XTJShoppingCartTableViewCell *)shoppingCartTableViewCell didUnSelectedGooods:(XTJGoodsModel *)goodsModel {
    
    [self.aggregateBar reducePriceAndCount:goodsModel];
}
#pragma mark -------------------------- XTJAggregateBarDelegate ----------------------------------------


- (void)aggregateBar:(XTJAggregateBar *)aggregateBar didSettleAccountsWithcheckAllStatus:(BOOL)checkAllStatus {
    
    if (checkAllStatus) {
        STConfirmAnOrderViewController *confirmAnOrderVC = [[STConfirmAnOrderViewController alloc]initWithGooddModels:self.goodsModelArray];
        [self.navigationController pushViewController:confirmAnOrderVC animated:YES];
        
    }else {
        
        NSMutableArray *seletcGoods = [[NSMutableArray alloc]init];
        for (XTJGoodsModel *model in self.goodsModelArray) {
            if (model.selected) {
                [seletcGoods addObject:model];
            }
        }
        STConfirmAnOrderViewController *confirmAnOrderVC = [[STConfirmAnOrderViewController alloc]initWithGooddModels:seletcGoods];
        [self.navigationController pushViewController:confirmAnOrderVC animated:YES];
        
        
        
    }
}

- (void)aggregateBar:(XTJAggregateBar *)aggregateBar didSelectedWithcheckAllStatus:(BOOL)checkAllStatus {
    
    if (checkAllStatus) {
        
        CGFloat price = 0.0;
        for (XTJGoodsModel *goodsModel in self.goodsModelArray) {
            price = price + [goodsModel.price floatValue];
            goodsModel.selected = YES;
            [self.tableView reloadData];
        }
        [aggregateBar setPrice:[NSString stringWithFormat:@"%.2f",price]];
        [aggregateBar setCount:[NSString stringWithFormat:@"%lu",(unsigned long)self.goodsModelArray.count]];
    }else {
        for (XTJGoodsModel *goodsModel in self.goodsModelArray) {
            
            goodsModel.selected = NO;
            [self.tableView reloadData];
        }
        [aggregateBar setPrice:@"0"];
        [aggregateBar setCount:[NSString stringWithFormat:@"%d",0]];
        
    }
}

- (NSInteger)numberGoodsInAggregateBar:(XTJAggregateBar *)aggregateBar {
    
   return  self.goodsModelArray.count;
}

#pragma mark -------------------------- DZNEmptyDataSetDelegate ----------------------------------------

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if ([UsersManager sharedUsersManager].currentUser) {
        
        NSString *string = [NSString TJ_localizableZHNsstring:@"没有数据请重试！" enString:@"No data, please try again!"];
        NSMutableAttributedString *mbString = [[NSMutableAttributedString alloc]initWithString:string];
        return mbString;
    }else {
        
        NSString *string = [NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"];
        NSMutableAttributedString *mbString = [[NSMutableAttributedString alloc]initWithString:string];
        return mbString;
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    if ([UsersManager sharedUsersManager].currentUser) {
        [self.tableView.mj_header beginRefreshing];
        
    }else {
        
         XTJLoginViewController *loginVC = [[XTJLoginViewController alloc]init];
        STBasicNavigationController *navVC = [[STBasicNavigationController alloc]initWithRootViewController:loginVC];
       
        [self presentViewController:navVC animated:YES completion:nil];
        
        
    }
}


@end
