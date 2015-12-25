//
//  UIScrollView+VKRefresh.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "UIScrollView+VKRefresh.h"
#import <objc/runtime.h>
#import "VKRefreshHeader.h"

@implementation UIScrollView (VKRefresh)

- (void)vk_addRefreshHeader {
    [self vk_removeRefreshHeader];
    
    VKRefreshHeader *fresh = [[VKRefreshHeader alloc]init];
    fresh.backgroundColor = [UIColor redColor];
    self.vkHeader = fresh;
    [self addSubview:self.vkHeader];
    
}

static char VKRefreshHeaderKey;
- (void)setVkHeader:(VKRefreshHeader * _Nullable)vkHeader {
    [self willChangeValueForKey:@"vkHeader"];
    objc_setAssociatedObject(self, &VKRefreshHeaderKey, vkHeader, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"vkHeader"];
}

- (VKRefreshHeader *)vkHeader {
    return objc_getAssociatedObject(self, &VKRefreshHeaderKey);
}

- (void)vk_removeRefreshHeader {
    if (self.vkHeader) {
        [self.vkHeader removeFromSuperview];
        self.vkHeader = nil;
    }
}

@end
