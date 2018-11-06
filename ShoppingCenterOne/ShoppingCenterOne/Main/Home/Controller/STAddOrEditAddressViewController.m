//
//  XTJEditAddressViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STAddOrEditAddressViewController.h"
#import "STEditAddressView.h"
#import "STAddressModel.h"

@interface STAddOrEditAddressViewController ()<STEditAddressViewDelegate>

@end

@implementation STAddOrEditAddressViewController


- (id)initWithType:(AddOrEditAddressViewControllerType)type {
    
    self = [super init];
    if (self) {
        if (type == AddOrEditAddressViewControllerTypeDefault || type == AddOrEditAddressViewControllerTypeEdit) {
            self.title =  NSLocalizedString(@"editController_title", @"编辑收货地址");//@"编辑收货地址";
        }else if(type == AddOrEditAddressViewControllerTypeAdd ) {
            self.title = NSLocalizedString(@"addController_title", @"添加收货地址");;
        }
    }
    return self;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor jk_colorWithHex:0xF6F6F6];
    
    __weak typeof(self) weakSelf = self;

    STEditAddressView *editeAddressView = [[[NSBundle mainBundle] loadNibNamed:@"STEditAddressView" owner:nil options:nil] lastObject];
    editeAddressView.delegate = self;
    [self.view addSubview:editeAddressView];
    [editeAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view.height).multipliedBy(.5);

    }];
   
}
 #pragma mark -------------------------- XTJEditAddressViewDelegate ----------------------------------------

- (void)editAddressView:(STEditAddressView *)editAddressView didSaveForAddress:(STAddressModel *)addressModel {
    
    [MBProgressHUD showMessage:@"提交中"];
    NSDictionary *parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id,
                                 @"address":addressModel.address,
                                 @"receiver_name":addressModel.receiver_name,
                                 @"receiver_phone":addressModel.receiver_phone
                                 };
    [[TJNetworking manager] post:kAddAddressURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"添加成功"];
            
           
        }else if ([response.responseObject[@"code"] isEqualToString:@"99"]) {
             [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"该地址已经存在"];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        TJLog("%@",response.userInfo);
    } finished:^{
         [MBProgressHUD hideHUD];
    }];
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
