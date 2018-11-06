//
//  XTJLanguageViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJLanguageViewController.h"

@interface XTJLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation XTJLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    self.title = NSLocalizedString(@"language", @"多语言模式");
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
        cell.textLabel.text = @"中文";
    } else if(indexPath.row  == 1) {
        
        cell.textLabel.text = @"English";
    }
    
    //    cell.contentView.backgroundColor = RandomColor;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row  == 1 ) {
        [MBProgressHUD showSuccess:@"抱歉，暂不支持！"];
    }
}



@end
