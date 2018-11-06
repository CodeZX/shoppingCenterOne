//
//  XTJEditAddressView.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/1.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "STEditAddressView.h"
#import "STAddressModel.h"



@interface STEditAddressView ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end
@implementation STEditAddressView


- (IBAction)saveBtn:(id)sender {
   
    if (self.nameTextField.text.length  &&
        self.phoneTextField.text.length &&
        self.cityTextField.text.length  &&
        self.addressTextField.text.length ) {
        
        if ([self.delegate respondsToSelector:@selector(editAddressView:didSaveForAddress:)]) {
            STAddressModel *addressModel = [[STAddressModel alloc]init];
            addressModel.receiver_name = self.nameTextField.text;
            addressModel.receiver_phone = self.phoneTextField.text;
            addressModel.address = self.addressTextField.text;
            [self.delegate editAddressView:self didSaveForAddress:addressModel];
        }
        
    }else {
        
        [MBProgressHUD showSuccess:@"请填写完整地址信息！"];
    }

   

}

@end
