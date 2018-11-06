//
//  XTJMineViewController.m
//  TJShop
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMineViewController.h"
#import "XTJMineHeaderView.h"
#import "XTJMineListModel.h"
#import "XTJMineTableViewCell.h"


#import "XTJLoginViewController.h"
#import "XTJRegisterViewController.h"
#import "STBasicNavigationController.h"


#import "XTJMyOrderViewController.h"
#import "XTJMyCollectionViewController.h"
#import "XTJLanguageViewController.h"
#import "XTJSettingViewController.h"
#import "XTJPersonalMessageViewController.h"
#import "XTJAboutViewController.h"
#import "XTJPersonalInfoViewController.h"
#import "TJPrivacyPolicyViewController.h"




@interface XTJMineViewController ()<UITableViewDelegate,UITableViewDataSource,XTJMineHeaderViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XTJMineHeaderView * headerView;
@property (nonatomic,strong) NSMutableArray *dataSurceAry;
@end

@implementation XTJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupData];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.headerView setupData];
//    self.tableView.contentOffset = CGPointMake(0, 100);
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
 
//    self.navigationController.navigationBar.hidden = YES;
  
   
    
}

- (void)leftBtnClick:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupData {
    
    userModel *user = [UsersManager sharedUsersManager].currentUser;
    if (user.user_id) {
        
        
        NSDictionary *parameters = @{@"user_id":user.user_id};
        [[TJNetworking manager] post:kPersonalURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
            if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
                
                NSLog(@"%@",response.responseObject[@"retData"]);
                [UsersManager sharedUsersManager].currentUser = [userModel mj_objectWithKeyValues:response.responseObject[@"retData"][@"personal"]];
                [[UsersManager sharedUsersManager] save];
            }
            
        } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
            
        } finished:^{
            
        }];
    }
    
    
}

- (void)setupUI {
    
    self.title = NSLocalizedString(@"Tabar_Mine_Title", @"我的");//@"我的";
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.tableView];
    
//    self.headerView.nameLabel.text = @"请登录";
    
    
    
}


#pragma mark -------------------------- XTJMineHeaderViewDelegate ----------------------------------------

- (void)mineHeaderView:(XTJMineHeaderView *)headerView didRegister:(UIButton *)RegisterBtn {
    
    XTJRegisterViewController *registerVC = [[XTJRegisterViewController alloc]init];
    //    [self.navigationController pushViewController:registerVC animated:YES];
    STBasicNavigationController *NC = [[STBasicNavigationController alloc]initWithRootViewController:registerVC];
    [self presentViewController:NC animated:YES completion:nil];
    
}

- (void)mineHeaderView:(XTJMineHeaderView *)headerView didLogin:(UIButton *)LoginBtn {
    
    
    
    XTJLoginViewController *loginVC = [[XTJLoginViewController alloc]init];
    //    [self.navigationController pushViewController:loginVC animated:YES];
    
    STBasicNavigationController *NC = [[STBasicNavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:NC animated:YES completion:nil];
}

- (void)mineHeaderView:(XTJMineHeaderView *)headerView didPortrait:(UIImageView *)potritImageView {
    
    XTJPersonalInfoViewController *infoVC  = [[XTJPersonalInfoViewController alloc]init];
    [self.navigationController pushViewController:infoVC animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSurceAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"MineCell";
    XTJMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XTJMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    cell.mineListModel = self.dataSurceAry[indexPath.row];
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    XTJMineListModel *model = self.dataSurceAry[indexPath.row];
    model.actionBlock(nil);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath; {
    
    return UITableViewCellEditingStyleInsert;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}




#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iPhoneX?-44:-20, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        
        
    }
    return _tableView;
}

- (XTJMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[XTJMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 220)];
        _headerView.iconImageView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = self;
    }
    return _headerView;
}


- (NSMutableArray *)dataSurceAry {
    __weak typeof(self) weakSelf = self;
    
    if (!_dataSurceAry) {
        
       
        XTJMineListModel *listModel1 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_message" title:NSLocalizedString(@"message", @"个人消息") actionBlock:^(id cell) {
            
            if (![UsersManager sharedUsersManager].currentUser) {
                 [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJPersonalMessageViewController *VC = [[XTJPersonalMessageViewController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }
           
            
        }];
        
        XTJMineListModel *listModel2 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_order" title:NSLocalizedString(@"myOrder", @"我的订单") actionBlock:^(id cell) {
            
            if (![UsersManager sharedUsersManager].currentUser) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJMyOrderViewController *VC = [[XTJMyOrderViewController alloc]init];
                [weakSelf.navigationController pushViewController:VC animated:YES];
                VC.automaticallyCalculatesItemWidths = YES;
                VC.menuViewStyle = WMMenuViewStyleLine;
            }
        }];
        
        XTJMineListModel *listModel3 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_collect1" title:NSLocalizedString(@"myCollect", @"我的收藏") actionBlock:^(id cell) {
            if (![UsersManager sharedUsersManager].currentUser) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJMyCollectionViewController *VC = [[XTJMyCollectionViewController alloc]init];
                [weakSelf.navigationController pushViewController:VC animated:YES];
                VC.menuViewStyle = WMMenuViewStyleLine;
            }
        }];
        XTJMineListModel *listModel4 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_about" title:NSLocalizedString(@"about", @"关于我们") actionBlock:^(id cell) {
            if (![UsersManager sharedUsersManager].currentUser) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJAboutViewController *VC = [[XTJAboutViewController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }];
        XTJMineListModel *listModel5 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_langue" title:NSLocalizedString(@"language", @"多语言模式") actionBlock:^(id cell) {
            if (![UsersManager sharedUsersManager].currentUser) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJLanguageViewController *VC = [[XTJLanguageViewController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }];
        XTJMineListModel *listModel6 = [[XTJMineListModel alloc]initWithLeftImageName:@"icon_set" title:NSLocalizedString(@"setting", @"设置") actionBlock:^(id cell) {
            if (![UsersManager sharedUsersManager].currentUser) {
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"请登录！" enString:@"please sign in!"]];
            }else {
                XTJSettingViewController *VC = [[XTJSettingViewController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }];
        
        XTJMineListModel *listModel7 = [[XTJMineListModel alloc]initWithLeftImageName:@"隐私策略-2" title:NSLocalizedString(@"intimacy", @"隐私策略") actionBlock:^(id cell) {
           
            TJPrivacyPolicyViewController *VC = [[TJPrivacyPolicyViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }];
        _dataSurceAry = [NSMutableArray arrayWithArray:@[listModel1,listModel2,listModel3,listModel4,listModel5,listModel6,listModel7]];
        
    }
    
    return _dataSurceAry;
}




@end
