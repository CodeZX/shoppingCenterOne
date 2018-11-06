//
//  XTJSettingViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJSettingViewController.h"
#import "AppDelegate.h"

@interface XTJSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation XTJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    self.title = NSLocalizedString(@"setting", @"设置");
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource  = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark -------------------------- UITableViewDelegate ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }
    //    cell.imageView.image = [UIImage imageNamed:@"logo"];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString TJ_localizableZHNsstring:@"清理缓存" enString:@"Clean up the cache"];
    } else if(indexPath.row  == 1) {
        
         cell.textLabel.text = [NSString TJ_localizableZHNsstring:@"退出账号" enString:@"Exit Account"];
    }
   
    //    cell.contentView.backgroundColor = RandomColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"清理成功！" enString:@"Cleared successfully"]];
    }else if(indexPath.row == 1) {
        
        [[UsersManager sharedUsersManager] logOut];
        [MBProgressHUD showSuccess:[NSString TJ_localizableZHNsstring:@"退出成功！"  enString:@"exit successfully!"]];
        
    
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app xtj_gotoHomePage];
    }
}


@end
