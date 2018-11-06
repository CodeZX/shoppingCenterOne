//
//  XTJManageAddressCell.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STAddressModel,STManageAddressCell;
@protocol  STManageAddressCellDeleDelegate <NSObject>
@optional
- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didSelectDefaultAddress:(STAddressModel *)addressMdoel;
- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didEditAddress:(STAddressModel *)addressMdoel;
- (void)manageAddressCell:(STManageAddressCell *)manageAddressCell didDeleteAddress:(STAddressModel *)addressMdoel;
@required
@end
@interface STManageAddressCell : UITableViewCell

@property (nonatomic,strong) STAddressModel *addressModel;
@property (nonatomic,weak) id<STManageAddressCellDeleDelegate> delegate;
@end
