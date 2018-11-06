//
//  XTJMyOrderViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMyOrderViewController.h"

#import "XTJMyOrderAllOrderViewController.h"
#import "XTJMyOrderNonPaymentViewController.h"
#import "XTJMyOrderPendingReceiptViewController.h"

@interface XTJMyOrderViewController ()
@property (nonatomic,strong) NSArray *childcontrollerArray;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation XTJMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


- (void)setupUI {
    self.title = NSLocalizedString(@"myOrder", @"我的订单");
    self.view.backgroundColor = [UIColor whiteColor];
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleArray.count;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return self.childcontrollerArray[index];
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleArray[index];
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return  CGRectMake(0,iPhoneX?88:64,DEVICE_SCREEN_WIDTH,30);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return  CGRectMake(0, 30,DEVICE_SCREEN_WIDTH,DEVICE_SCREEN_HEIGHT);
}

#pragma mark -------------------------- lazy load ----------------------------------------

- (NSArray *)childcontrollerArray {
    if (!_childcontrollerArray) {
        _childcontrollerArray = @[ [[XTJMyOrderAllOrderViewController alloc]init],
                              [[XTJMyOrderNonPaymentViewController alloc]init],
                              [[XTJMyOrderPendingReceiptViewController alloc]init] ];
    }
    return _childcontrollerArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[   [NSString TJ_localizableZHNsstring:@"全部订单" enString:@"All orders"],
                        [NSString TJ_localizableZHNsstring:@"待付款" enString:@"Pending payment"],
                        [NSString TJ_localizableZHNsstring:@"待收货" enString:@"Pending receipt"]
                        ];
    }
    return _titleArray;
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
