//
//  XTJLoginViewController.m
//  TJShop
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//  登录

#import "XTJLoginViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "XTJRegisterViewController.h"
#import "XTJFindPassWordViewController.h"
@interface XTJLoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView * iconImageView; ///< icon图标
@property (strong, nonatomic) UITextField * phoneTextField; ///< 输入手机号
@property (strong, nonatomic) UITextField * passwordTextField; ///< 输入密码
@property (strong, nonatomic) UIButton * registerButton; ///< 立即注册按钮
@property (strong, nonatomic) UIButton * forgetPsdButton; ///< 忘记密码按钮
@property (strong, nonatomic) UIButton * loginButton; ///< 登录按钮
//下划线
@property (strong, nonatomic) UIView * firstLineView; ///<下划线1
@property (strong, nonatomic) UIView * secondLineView; ///<下划线2


@end

@implementation XTJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = TJString(@"nav-login");
    self.view.backgroundColor = [UIColor whiteColor];
    [self xtj_setUI];
}


- (void)close:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UI设置
- (void)xtj_setUI {
    
    


    UIImage *leftImage = [UIImage imageNamed:@"icon_return"];
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
   
    //创建icon
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(35);
        make.height.mas_equalTo(63);
        make.width.mas_equalTo(63);
    }];
    
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(35);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(110);
        make.right.equalTo(self.view.mas_right).offset(-35);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.firstLineView];
    [self.firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField.mas_left);
        make.top.equalTo(self.firstLineView.mas_bottom).offset(20);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.secondLineView];
    [self.secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLineView.mas_left);
        make.right.equalTo(self.firstLineView.mas_right);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.top.equalTo(self.secondLineView.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.forgetPsdButton];
    [self.forgetPsdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordTextField.mas_right);
        make.top.equalTo(self.secondLineView.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.right.equalTo(self.passwordTextField.mas_right);
        make.top.equalTo(self.secondLineView.mas_bottom).offset(80);
        make.height.mas_equalTo(44);
    }];
}


#pragma mark - button点击事件
//立即注册
- (void)registerAction {
    XTJRegisterViewController * vc = [[XTJRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//忘记密码
- (void)forgetPsdAction {
    XTJFindPassWordViewController * vc = [[XTJFindPassWordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//登录
- (void)loginAction {
    
    [self.passwordTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    
    if (self.phoneTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [MBProgressHUD showError:[NSString TJ_localizableZHNsstring:@"请输入账号或密码" enString:@"Please enter an account or password"]];
        return;
    } else {
        
        [self xtj_loginNetWorking];
    }
    
}

#pragma mark - 网络请求
// 登录接口
- (void)xtj_loginNetWorking {
    NSDictionary * dic = @{@"phone_num":self.phoneTextField.text,
                        @"pwd":self.passwordTextField.text
                        };
    [[TJNetworking manager] post:kLoginURL parameters:dic progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            
            if (response.responseObject[@"retData"]) {
                NSString *user_ID = response.responseObject[@"retData"][@"user_id"];
//                 User *user = [User sharedUser];
//                 user.user_id = user_ID;
                userModel *user = [[userModel alloc]init];
                user.user_id = user_ID;
                if ([[UsersManager sharedUsersManager] loginWithUser:user]) {
                    [self userInfo];
                };
               
               
            }
        }
//        NSDictionary *responseDic = (NSDictionary *)response;
//
//        int codeState = [NonEmptyString([responseDic objectForKey:@"code"]) intValue];
//        NSDictionary *dataDic = [responseDic objectForKey:@"retData"];
//        NSString *msgStr = NonEmptyString([responseDic objectForKey:@"msg"]);
//        TJLog(@"%@",msgStr);
//        if( codeState == 0 && NSDictionaryMatchAndCount(dataDic)){
//            NSDictionary *dictUser = @{@"userName":self.phoneTextField.text,@"passWord":self.passwordTextField.text,@"user_id":dataDic[@"user_id"]};
//            [TJSaveTool setObject:dictUser forKey:@"isAutoLogin"];
//            NSString *json = [dataDic mj_JSONString];
//            User *user = [User sharedUser];
//            user = [User mj_objectWithKeyValues:json];
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            [app xtj_gotoHomePage];
//        }else{
//            [MBProgressHUD showError:msgStr];
//        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {

        NSLog(@"%@", response.userInfo);
    } finished:^{

    }];
}

- (void)userInfo {
    
    userModel *user = [UsersManager sharedUsersManager].currentUser;
    if (user.user_id) {
        
        
        NSDictionary *parameters = @{@"user_id":user.user_id};
        [[TJNetworking manager] post:kPersonalURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(TJNetworkingSuccessResponse * _Nonnull response) {
            if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
                
                NSLog(@"%@",response.responseObject[@"retData"]);
                [UsersManager sharedUsersManager].currentUser = [userModel mj_objectWithKeyValues:response.responseObject[@"retData"][@"personal"]];
                [[UsersManager sharedUsersManager] save];
                [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"登录成功" enString:@"succeed"]];
                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [app xtj_gotoHomePage];
            }
            
        } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
            
        } finished:^{
            
        }];
    }
}

- (void)xtj_registerToIMNetWorking{
    
//    NSDictionary * dic = @{@"user_id":self.userModel.user_id};
//    [[TJNetworking manager] post:kLoginURL parameters:dic progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
//        NSDictionary * dict = response.responseObject[@"body"];
//
//
//    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
//
//        NSLog(@"%@", response.userInfo);
//    } finished:^{
//
//    }];
    
    
    
//    NSString *url = [NSString stringWithFormat:@"%@/select/insertInfo?user_id=%@",APIURL_BASE, self.userModel.user_id];
//    NSDictionary *dic = @{@"user_id":self.userModel.user_id};
//    [NEAFNetworkingHelper POSTWithUrl:url params:dic success:^(id response) {
//        NSDictionary *dict = (NSDictionary *)response;
//        int state = [NonEmptyString([dict objectForKey:@"code"]) intValue];;
//        if (state == 0) {
//            [self selectOneInfo];
//        }else{
//
//        }
//    } fail:^(NSError *error) {
//        [PublicManager showToast:@"服务器断开连接,请稍后再试!"];
//    } showHUD:@""];
    
}

#pragma mark - 懒加载
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"logo"];
        _iconImageView.hidden = YES;
    }
    return _iconImageView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;///<设置圆角
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//输入框中是否有个叉号,用于一次性删除输入框中的内容
        _phoneTextField.adjustsFontSizeToFitWidth = YES;//设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
        _phoneTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.placeholder = [NSString TJ_localizableZHNsstring:@"请输入手机号" enString:@"Please enter phone number"];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.textColor = [UIColor blackColor];
        _phoneTextField.font = [UIFont fontWithName:FONTNAME size:FONTSIZE_CELL_TITLE];
        _phoneTextField.returnKeyType = UIReturnKeyNext;//return键变成什么键
        _phoneTextField.keyboardType = UIKeyboardTypeDefault;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}


- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;///<设置圆角
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//输入框中是否有个叉号,用于一次性删除输入框中的内容
        _passwordTextField.adjustsFontSizeToFitWidth = YES;//设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = [NSString TJ_localizableZHNsstring:@"请输入密码" enString:@"Please enter your password"];
        _passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.textColor = [UIColor blackColor];
        _passwordTextField.font = [UIFont fontWithName:FONTNAME size:FONTSIZE_CELL_TITLE];
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:[NSString TJ_localizableZHNsstring:@"立即注册" enString:@"Sign up now"] forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)forgetPsdButton {
    if (!_forgetPsdButton) {
        _forgetPsdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPsdButton setTitle:[NSString TJ_localizableZHNsstring:@"忘记密码?" enString:@"忘记密码?"] forState:UIControlStateNormal];
        [_forgetPsdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _forgetPsdButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetPsdButton addTarget:self action:@selector(forgetPsdAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPsdButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:[NSString TJ_localizableZHNsstring:@"登录" enString:@"Log in"] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor jk_colorWithHex:0xD54851];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIView *)firstLineView {
    if (!_firstLineView) {
        _firstLineView = [[UIView alloc] init];
        _firstLineView.backgroundColor = [UIColor grayColor];
    }
    return _firstLineView;
}

- (UIView *)secondLineView {
    if (!_secondLineView) {
        _secondLineView = [[UIView alloc] init];
        _secondLineView.backgroundColor = [UIColor grayColor];
    }
    return _secondLineView;
}
@end
