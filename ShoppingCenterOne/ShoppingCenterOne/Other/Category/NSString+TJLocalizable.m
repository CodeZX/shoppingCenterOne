//
//  NSString+TJLocalizable.m
//  ShoppingCenterOne
//
//  Created by 周鑫 on 2018/11/5.
//  Copyright © 2018年 TJ. All rights reserved.
//

#import "NSString+TJLocalizable.h"

@implementation NSString (TJLocalizable)
+ (NSString *)TJ_localizableZHNsstring:(NSString *)zh_Hans enString:(NSString *)en; {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage isEqualToString:@"en-US"] || [currentLanguage isEqualToString:@"en"]) {
        return en;
    }else {
        return zh_Hans;
    }
}
@end
