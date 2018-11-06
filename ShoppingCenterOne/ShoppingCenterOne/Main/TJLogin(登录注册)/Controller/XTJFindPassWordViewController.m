//
//  XTJFindPassWordViewController.m
//  TJShop
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//  找回密码

#import "XTJFindPassWordViewController.h"

@interface XTJFindPassWordViewController ()<UITextFieldDelegate>
{
    int randNumber;
}
@property (strong, nonatomic) UIImageView * iconImageView; ///< icon图标
@property (strong, nonatomic) UITextField * phoneTextField; ///< 输入手机号
@property (strong, nonatomic) UITextField * passwordTextField; ///< 输入密码
@property (strong, nonatomic) UITextField * registerTextField; ///< 验证码
@property (strong, nonatomic) UIButton * loginButton; ///< 登录按钮
//下划线
@property (strong, nonatomic) UIView * firstLineView; ///<下划线1
@property (strong, nonatomic) UIView * secondLineView; ///<下划线2
@property (strong, nonatomic) UIView * lastLineView; ///< 下划线3
@property (assign, nonatomic) NSInteger seconds;
@property (strong, nonatomic) UIButton * sendCodeBtn; ///<获取验证码
@end

@implementation XTJFindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self xtj_setUI];
    
}

#pragma mark - UI设置
- (void)xtj_setUI {
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
    
    [self.view addSubview:self.registerTextField];
    [self.registerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField.mas_left);
        make.top.equalTo(self.firstLineView.mas_bottom).offset(20);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(40);
    }];

    [self.view addSubview:self.secondLineView];
    [self.secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLineView.mas_left);
        make.right.equalTo(self.firstLineView.mas_right);
        make.top.equalTo(self.registerTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField.mas_left);
        make.top.equalTo(self.secondLineView.mas_bottom).offset(20);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.lastLineView];
    [self.lastLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLineView.mas_left);
        make.right.equalTo(self.firstLineView.mas_right);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.right.equalTo(self.passwordTextField.mas_right);
        make.top.equalTo(self.lastLineView.mas_bottom).offset(60);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *rivacyLab = [UILabel XTJ_createWithTitle:@"注册即代表你同意《隐私政策》" titleColor:[UIColor redColor] font:12 textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:rivacyLab];
    [rivacyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        
    }];
}


#pragma mark - 按钮点击事件
//注册
- (void)registerAction {
    
}

//获取验证码
- (void)didRegisterAction {
    if (self.phoneTextField.text.length <= 0) {
        [MBProgressHUD showError:@"请输入手机号码"];
        return;
    }
    if (![NSString isMobileNumber:self.phoneTextField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    randNumber = arc4random()%899999+100000;
    NSUserDefaults *randCode = [NSUserDefaults standardUserDefaults];
    NSString *randStr = [NSString stringWithFormat:@"%d",randNumber];
    [randCode setObject:randStr forKey:@"randCode"];
    NSString * sms_content = [NSString stringWithFormat:@"%@是本次操作的手机验证码，如非本人操作，请忽略本短信。【51工匠】",randStr];
    NSDictionary *dic = @{@"msisdn":self.phoneTextField.text,@"sms_content":sms_content, @"client_ip":@"127.0.0.1", @"company_id":@"CP2017021701",@"sms_type":@"1",@"priority":@"1",@"pre_process_time":@"0"};
    [self phoneRecvNumberByParam:dic];
    [self sentPhoneCodeTimeMethod];
}

-(void)sentPhoneCodeTimeMethod{
    //倒计时时间 - 60秒
    __block NSInteger timeOut = 59;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -> dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式->
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendCodeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:FONTSIZE_CELL_TITLE];
                [self.sendCodeBtn  setUserInteractionEnabled:YES];
            });
        }else{
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld", seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%@s后重新发送", strTime] forState:UIControlStateNormal];
                self.sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                [UIView commitAnimations];
                //计时器件不允许点击
                [self.sendCodeBtn  setUserInteractionEnabled:NO];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}


#pragma mark - 网络请求
//获取验证码
- (void)phoneRecvNumberByParam:(NSDictionary *)params{
    TJLog(@"入参:%@",params);
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    //https ipv6的设置
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager POST:kCAPTCHAURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (NSDictionaryMatchAndCount(responseObject)) {
            NSDictionary *resDic = (NSDictionary *)responseObject;
            NSLog(@"url:%@,返参:%@",kCAPTCHAURL,resDic);
            int state = [NonEmptyString(resDic[@"status"]) intValue];
            if ( state == 0 ) {
                [MBProgressHUD showSuccess:@"短信发送成功!"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网太弱,再试试咯!"];
    }];
}

#pragma mark - 懒加载
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"logo"];
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
        _phoneTextField.placeholder = @"请输入手机号";
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
        _passwordTextField.placeholder = @"请输入新密码";
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

- (UITextField *)registerTextField {
    if (!_registerTextField) {
        _registerTextField = [[UITextField alloc] init];
        _registerTextField.borderStyle = UITextBorderStyleRoundedRect;///<设置圆角
        _registerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//输入框中是否有个叉号,用于一次性删除输入框中的内容
        _registerTextField.adjustsFontSizeToFitWidth = YES;//设置为YES时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
        _registerTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login"]];
        _registerTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 10, 88, 30);
        button.titleLabel.font = [UIFont fontWithName:FONTNAME size:FONTSIZE_CELL_TITLE];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button addTarget:self action:@selector(didRegisterAction) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:KBlueColor forState:UIControlStateNormal];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        button.layer.cornerRadius = 3.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = KBlueColor.CGColor;
        button.layer.borderWidth = 1.0f;
        _registerTextField.rightView = button;///<设置右侧按钮
        _registerTextField.rightViewMode = UITextFieldViewModeAlways;///<一直显示
        
        _registerTextField.placeholder = @"请输入验证码";
        _registerTextField.borderStyle = UITextBorderStyleNone;
        _registerTextField.textColor = [UIColor blackColor];
        _registerTextField.font = [UIFont fontWithName:FONTNAME size:FONTSIZE_CELL_TITLE];
        _registerTextField.returnKeyType = UIReturnKeyNext;//return键变成什么键
        _registerTextField.keyboardType = UIKeyboardTypeDefault;
        _registerTextField.delegate = self;
    }
    return _registerTextField;
}


- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"确认" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = KBlueColor;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginButton.layer.cornerRadius = 5;
        _loginButton.clipsToBounds = YES;
        [_loginButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
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

- (UIView *)lastLineView {
    if (!_lastLineView) {
        _lastLineView = [[UIView alloc] init];
        _lastLineView.backgroundColor = [UIColor grayColor];
    }
    return _lastLineView;
}

@end
