//
//  XTJServerAddress.h
//  TJShop
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STServerAddress : NSObject
TJKIT_EXTERN NSString * kHostURL;

/** 登录接口 */
TJKIT_EXTERN NSString * kLoginURL;
/** 注册接口 */
TJKIT_EXTERN NSString * kRegisterURL;
/** 获取验证码 */
TJKIT_EXTERN NSString * kCAPTCHAURL;

#pragma mark - 首页
/**首页banner  */
TJKIT_EXTERN NSString * kHomeBannerURL;
/**首页分类按钮  */
TJKIT_EXTERN NSString * kHomeCategoryURL;
/**首页推荐商品  */
TJKIT_EXTERN NSString * kHomeListProductURL;
/**首页推荐商品  */
TJKIT_EXTERN NSString * kCategoryGoodsURL;
/**生成订单  */
TJKIT_EXTERN NSString * kCreateOrderURL;

/**地址列表  */
TJKIT_EXTERN NSString * kAddressListURL;
/**添加地址  */
TJKIT_EXTERN NSString * kAddAddressURL;
/**删除地址  */
TJKIT_EXTERN NSString * kDeleteAddressURL;

#pragma mark - 购物车
/**购物车列表*/
TJKIT_EXTERN NSString * kShoppingCartURL;
/**加入购物车*/
TJKIT_EXTERN NSString * kAddToShoppingCartURL;
/**加入购物车*/
TJKIT_EXTERN NSString * kDeleteShoppingCartURL;


#pragma mark - 订单
/**全部订单*/
TJKIT_EXTERN NSString * kAllOrderURL;


#pragma mark - 收藏
/**商品收藏*/
TJKIT_EXTERN NSString * kGoodsCollectURL;
/**加入商品收藏*/
TJKIT_EXTERN NSString * kGoodsAddToCollectURL;
/**删除商品收藏*/
TJKIT_EXTERN NSString * kDeleteCollectURL;







#pragma mark - 我的
/**个人信息*/
TJKIT_EXTERN NSString * kPersonalURL;
/**个修改人信息*/
TJKIT_EXTERN NSString * kModifyUserInfoURL;
/**上传头像*/
TJKIT_EXTERN NSString * kUploadPortraitURL;



@end
