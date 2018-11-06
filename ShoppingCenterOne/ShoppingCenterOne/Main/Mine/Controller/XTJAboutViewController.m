//
//  XTJAboutViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/7.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJAboutViewController.h"
#import <WebKit/WebKit.h>

@interface XTJAboutViewController ()

@end

@implementation XTJAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}


- (void)setupUI  {
    
    self.title = NSLocalizedString(@"about", @"关于我们");
    self.view.backgroundColor = WhiteColor;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"https://568tj.cn"];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];

    
//    UILabel *titleLab = [[UILabel alloc]init];
//    titleLab.text = @"网络天下美食 —— 每日四条";
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.textColor = [UIColor blackColor];
//    [self.view addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
