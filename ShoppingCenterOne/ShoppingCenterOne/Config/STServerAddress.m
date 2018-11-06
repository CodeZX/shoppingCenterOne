//
//  XTJServerAddress.m
//  TJShop
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//  网络请求接口

#import "STServerAddress.h"

@implementation STServerAddress

/** 接口根路径 */
#if NETWORK_ENVIRONMENT == 0
NSString * kHostURL = @"http://45.63.35.70:8080";
#else
NSString * kHostURL = @"http://45.63.35.70:8080";
#endif

#pragma mark - 登录
/** 登录接口 */
NSString * kLoginURL = @"/mall_tj/user/login";
/** 注册接口 */
NSString * kRegisterURL = @"http://45.63.35.70:8080/mall_tj/user/register";
/** 获取验证码 */
NSString * kCAPTCHAURL =  @"http://45.63.35.70:8080/mall_tj/user/send_sms_code";//@"http://smspay.api.365pays.cn/sms/send.do";



#pragma mark - 首页
/**首页banner  */
NSString * kHomeBannerURL = @"/mall_tj/start_page/get_banner";
/**首页分类按钮  */
NSString * kHomeCategoryURL = @"/mall_tj/start_page/category";
/**首页推荐商品  */
NSString * kHomeListProductURL = @"/mall_tj/start_page/list_product";
/**分类  */
NSString * kCategoryGoodsURL = @"/mall_tj/category/list_product";
/**生产订单  */
NSString * kCreateOrderURL = @"/mall_tj/shopping/create_order";
/**选择地址  */
NSString * kAddressListURL = @"/mall_tj/address/select";
/**添加地址  */
NSString * kAddAddressURL = @"/mall_tj/address/add";
/**删除地址  */
NSString * kDeleteAddressURL = @"/mall_tj/address/delete";

#pragma mark - 购物车
/**购物车列表  */
NSString * kShoppingCartURL = @"/mall_tj/user/cart";
/**加入购物车  */
NSString * kAddToShoppingCartURL = @"/mall_tj/shopping/join_cart";
/**删除购物车  */
NSString * kDeleteShoppingCartURL = @"/mall_tj/shopping/delete_cart";



#pragma mark - 订单
/**ww全部订单  */
NSString * kAllOrderURL = @"/mall_tj/shopping/list_order";


#pragma mark - 收藏
/**商品收藏  */
NSString * kGoodsCollectURL = @"/mall_tj/user/collect";
/**加入收藏  */
NSString * kGoodsAddToCollectURL = @"/mall_tj/shopping/join_collect";
/**删除收藏  */
NSString * kDeleteCollectURL = @"/mall_tj/shopping/delete_collect";



#pragma mark - 消息

#pragma mark - 问一问

#pragma mark - 发布

#pragma mark - 我的
/**个人中心信息     */
NSString * kPersonalURL = @"/mall_tj/user/personal";
/**修改用户资料     */
NSString * kModifyUserInfoURL = @"/mall_tj/user/modify";
/**修改用户资料     */
NSString * kUploadPortraitURL = @"/mall_tj/user/upload";




@end
