//
//  XTJEditAddressView.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STEditAddressView,STAddressModel;

@protocol  STEditAddressViewDelegate <NSObject>
@optional
- (void)editAddressView:(STEditAddressView *)editAddressView didSaveForAddress:(STAddressModel*)addressModel;
@required
@end
@interface STEditAddressView : UIView
@property (nonatomic,weak) id<STEditAddressViewDelegate> delegate;
@end
