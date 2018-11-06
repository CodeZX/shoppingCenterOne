//
//  XTJEditAddressViewController.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, AddOrEditAddressViewControllerType) {
    AddOrEditAddressViewControllerTypeDefault,
    AddOrEditAddressViewControllerTypeAdd,
    AddOrEditAddressViewControllerTypeEdit,
};

@interface STAddOrEditAddressViewController : UIViewController
- initWithType:(AddOrEditAddressViewControllerType)type;

@end
