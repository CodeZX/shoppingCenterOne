//
//  TJNetworkingSendManager.h
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJNetworkProtocol.h"

@interface TJNetworkingSendManager : NSObject <TJNetworkDelegate>

/** 代理 */
@property (nonatomic, weak  ) id <TJNetworkDelegate> delegate;

+ (instancetype)sharedSendManager;

@end
