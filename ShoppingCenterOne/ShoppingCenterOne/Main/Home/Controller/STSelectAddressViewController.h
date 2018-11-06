//
//  XTJSelectAddressViewController.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STSelectAddressViewController,STAddressModel;
@protocol  selectAddressViewControllerDelegate <NSObject>
@optional
- (void)selectAddressViewController:(STSelectAddressViewController *)selectAddressVC address:(STAddressModel *)addressModel;
@required
@end
@interface STSelectAddressViewController : UIViewController

@property (nonatomic,weak) id<selectAddressViewControllerDelegate> delegate;
@end
