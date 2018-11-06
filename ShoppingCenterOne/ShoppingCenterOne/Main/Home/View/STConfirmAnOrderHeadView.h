//
//  XTJConfirmAnOrderHeadView.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/9.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class STConfirmAnOrderHeadView,STAddressModel;

@protocol STConfirmAnOrderHeadViewDelegate  <NSObject>
@optional
- (void)confirmAnOrderHeadView:(STConfirmAnOrderHeadView *)headView didAddAddress:(UIButton *)btn;
- (void)confirmAnOrderHeadView:(STConfirmAnOrderHeadView *)headView didSelectAddress:(UITapGestureRecognizer *)tap;
@required
@end
@interface STConfirmAnOrderHeadView : UIView
@property (nonatomic,strong) STAddressModel *addressModel;
@property (nonatomic,weak) id<STConfirmAnOrderHeadViewDelegate> delegate;
@end
