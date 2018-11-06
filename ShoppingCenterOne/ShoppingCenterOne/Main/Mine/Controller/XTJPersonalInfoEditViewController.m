//
//  XTJPersonalInfoEditViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/15.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJPersonalInfoEditViewController.h"

typedef NS_ENUM(NSUInteger, editType) {
    editTypeUnknown,
    editTypeName,
    editTypePhone
};



@interface XTJPersonalInfoEditViewController ()
@property (nonatomic,weak) UITextField *editTextField;
@property (nonatomic,weak) UIButton *saveBtn;
@property (nonatomic,assign) editType type;
@end

@implementation XTJPersonalInfoEditViewController

- (instancetype)initWithEditName {
    self = [super init];
    if (self) {
        self.title = @"编辑用户名";
        self.type = editTypeName;
    }
    return self;
}


- (instancetype)initWithEditPhone {
    
    self = [super init];
    if (self) {
        self.title =  @"更改手机号码";
        self.type = editTypePhone;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {

    __weak typeof(self) weakSelf = self;
    UITextField *editTextField = [[UITextField alloc]init];
    editTextField.borderStyle = UITextBorderStyleRoundedRect;
    if (self.type == editTypeName) {
        editTextField.placeholder = [UsersManager sharedUsersManager].currentUser.name;
    } else if(self.type == editTypePhone) {
        
        editTextField.placeholder = [UsersManager sharedUsersManager].currentUser.phone_num;
    }
    
    [self.view addSubview:editTextField];
    self.editTextField = editTextField;
    [self.editTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(iPhoneX?120:100);
        make.left.equalTo(weakSelf.view).offset(30);
        make.right.equalTo(weakSelf.view).offset(-30);
        make.height.equalTo(40);
    }];
    

    UIButton *saveBtn = [UIButton XTJ_createWithTitle:@"保存" titleColor:[UIColor whiteColor] font:16 selectTitle:nil imageName:nil selectImageName:nil backgroundColor:[UIColor orangeColor]];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    self.saveBtn = saveBtn;
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editTextField.bottom).offset(20);
        make.left.equalTo(weakSelf.view).offset(30);
        make.right.equalTo(weakSelf.view).offset(-30);
        make.height.equalTo(44);
    }];
    
}

- (void)saveBtnClicked:(UIButton *)btn  {
   
    if (!self.editTextField.text.length) {
        if (self.type == editTypePhone) {
              [MBProgressHUD showSuccess:@"請輸入号码"];
        } else if(self.type == editTypeName) {
            [MBProgressHUD showSuccess:@"請輸入用戶名"];
        }
        
        return;
    }
    
    NSDictionary *parameters;
    if(self.type  == editTypeName) {
        parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id,
                       @"name":self.editTextField.text};
    }else if(self.type == editTypePhone) {
         parameters = @{@"user_id":[UsersManager sharedUsersManager].currentUser.user_id,
                        @"phone_num":self.editTextField.text};
    }
    [[TJNetworking manager] post:kModifyUserInfoURL parameters:parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
        if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
            [UsersManager sharedUsersManager].currentUser.name = self.editTextField.text;
            [[UsersManager sharedUsersManager] save];
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
        
    } finished:^{
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
