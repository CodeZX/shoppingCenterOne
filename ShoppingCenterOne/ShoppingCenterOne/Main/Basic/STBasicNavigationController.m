//
//  STNavigationController.m
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STBasicNavigationController.h"

@interface STBasicNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation STBasicNavigationController
+ (void)initialize {
    
    if (self == [STBasicNavigationController class]) {
        // 1. 获取导航条标识
        UINavigationBar * navbar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[STBasicNavigationController class]]];
        
        //获取导航条颜色
        UIColor * navColor = [UIColor jk_colorWithHex:0xF6F6F6];
        //把颜色生成图片
        UIImage * alphaImg = [UIImage imageWithColor:navColor];
        [navbar setBarTintColor:navColor];
        //        [navbar setBackgroundImage:alphaImg forBarMetrics:UIBarMetricsDefault];
        // 设置字体颜色大小
        NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
        // 字体大小
        dictM[NSFontAttributeName] = [UIFont systemFontOfSize:20];
        // 字体颜色
        dictM[NSForegroundColorAttributeName] = [UIColor blackColor];
        
        navbar.titleTextAttributes = dictM;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer * pan =  [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UINavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 当显示的控制器为非根控制器时，设置导航条左侧返回按钮
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage renderOriginalImageWithImageName:@"icon_return"] style:0 target:self action:@selector(didClickBackBarButton:)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action method
- (void)didClickBackBarButton:(UIBarButtonItem *)barBtnItem {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
// 当开始滑动的就会调用 如果返回YES，可以滑动；返回NO，禁止手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 当是跟控制器不让移除(禁止)，非根控制器，允许移除控制
    BOOL open = self.viewControllers.count > 1;
    return open;
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
