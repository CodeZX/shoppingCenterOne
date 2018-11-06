//
//  XTJPageControl.m
//  轮播图
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 徐冬苏. All rights reserved.
//

#import "XTJPageControl.h"

@implementation XTJPageControl

- (void)setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 10;
        
        size.width = 10;
        
        subview.layer.cornerRadius = size.width / 2;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x , subview.frame.origin.y,
                                     
                                     size.width,size.height)];
        
    }
    
}


@end
