//
//  TJBasicTabBarController.m
//  ST
//
//  Created by 周鑫 on 2018/9/28.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "STBasicTabBarController.h"
#import "STHomeViewController.h"
//#import "STShoppingCartViewController.h"
//#import "STMineViewController.h"
#import "STBasicNavigationController.h"
#import "XTJMineViewController.h"
#import "XTJShoppingCartViewController.h"



@interface STBasicTabBarController ()

@end

@implementation STBasicTabBarController


+ (void)initialize {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.00];
    [self setAllChildVC];
}

- (void)setAllChildVC {
   
    // 首页
    STHomeViewController *homeVC = [[STHomeViewController alloc]init];
    [self addChildViewController:homeVC title:NSLocalizedString(@"Tabar_Home_Title", @"home") imageName:@"tabBar_home" selectImagenName:@"tabBar_home_select"];
    
    //购物车
    XTJShoppingCartViewController *shoppingCartVC = [[XTJShoppingCartViewController alloc]init];
    [self addChildViewController:shoppingCartVC title:NSLocalizedString(@"Tabar_shoppingCart_Title", @"购物车") imageName:@"tabBar_shoppingCart" selectImagenName:@"tabBar_shoppingCart_select"];
    
    // 我的
    XTJMineViewController *mineVC = [[XTJMineViewController alloc]init];
    [self addChildViewController:mineVC title:NSLocalizedString(@"Tabar_Mine_Title", @"我的") imageName:@"tabBar_User" selectImagenName:@"tabBar_User_select"];
    
}



- (void)addChildViewController:(STBasicViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImagenName:(NSString *)selectImageName {
    
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage renderOriginalImageWithImageName:imageName];
    childVC.tabBarItem.selectedImage = [UIImage renderOriginalImageWithImageName:selectImageName];
    
    STBasicNavigationController *NavC = [[STBasicNavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:NavC];
}



@end
