//
//  TJPrivacyPolicyViewController.m
//  ST
//
//  Created by 周鑫 on 2018/10/16.
//  Copyright © 2018年 TJ. All rights reserved.
//  隐私策略

#import "TJPrivacyPolicyViewController.h"
#import <WebKit/WebKit.h>

@interface TJPrivacyPolicyViewController ()

@end

@implementation TJPrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}


- (void)setupUI {
    
    self.title = NSLocalizedString(@"intimacy", @"隐私策略");
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"https://app1.bk7773.com/meiri/"];
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    
    
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
