//
//  XTJMyCollectionViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/6.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJMyCollectionViewController.h"
#import "XTJMyCollectionShopViewController.h"
#import "XTJMyCollectionGoodsViewController.h"

@interface XTJMyCollectionViewController ()
@property (nonatomic,strong) NSArray *childcontrollerArray;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation XTJMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    self.title = NSLocalizedString(@"myCollect", @"我的收藏");
    self.view.backgroundColor = [UIColor whiteColor];
    self.menuView.backgroundColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
//    self.showOnNavigationBar = YES;
    
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return 2;
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
        _childcontrollerArray = @[[[XTJMyCollectionGoodsViewController alloc]init],
                                  [[XTJMyCollectionShopViewController alloc]init]];
    }
    return _childcontrollerArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[   [NSString TJ_localizableZHNsstring:@"商品" enString:@"commodity"],
                        [NSString TJ_localizableZHNsstring:@"店铺" enString:@"Store"]
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
