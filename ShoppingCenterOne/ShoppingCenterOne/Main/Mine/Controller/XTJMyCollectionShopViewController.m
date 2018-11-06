//
//  XTJMyCollectionShopViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//  店铺

#import "XTJMyCollectionShopViewController.h"
#import "XTJMyCollectionShopCell.h"

@interface XTJMyCollectionShopViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation XTJMyCollectionShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource  = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    
}

#pragma mark -------------------------- UITableViewDelegate ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    XTJMyCollectionShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XTJMyCollectionShopCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:@"logo"];
    cell.textLabel.text = @"零食旗舰店";
    cell.detailTextLabel.text = @"为您提供各类零食";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}


#pragma mark -------------------------- DZNEmptyDataSetDelegate ----------------------------------------
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *string = [NSString TJ_localizableZHNsstring: @"没有收藏的店铺" enString:@"No collection of stores"];
    NSAttributedString  *mbString = [[NSAttributedString alloc]initWithString:string];
    return mbString;
}


@end
