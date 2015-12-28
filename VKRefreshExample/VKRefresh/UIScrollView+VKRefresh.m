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
#import "VKRefreshFooter.h"

@implementation UIScrollView (VKRefresh)

//header
- (void)vk_addRefreshHeader {
    [self vk_removeRefreshHeader];
    
    VKRefreshHeader *fresh = [[VKRefreshHeader alloc]init];
    self.vkHeader = fresh;
    [self addSubview:self.vkHeader];
    
}

//动态绑定属性vkHeader到UIScrollView上面
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


//footer
- (void)vk_addRefreshFooter {
    [self vk_removeRefreshFooter];
    
    VKRefreshFooter *fresh = [[VKRefreshFooter alloc]init];
    self.vkFooter = fresh;
    [self addSubview:self.vkFooter];
}

//动态绑定属性vkFooter到UIScrollView上面
static char VKRefreshFooterKey;
- (void)setVkFooter:(VKRefreshFooter * _Nullable)vkFooter {
    [self willChangeValueForKey:@"vkFooter"];
    objc_setAssociatedObject(self, &VKRefreshFooterKey, vkFooter, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"vkFooter"];
}

- (VKRefreshFooter *)vkFooter {
    return objc_getAssociatedObject(self, &VKRefreshFooterKey);
}

-(void)vk_removeRefreshFooter {
    if (self.vkFooter) {
        [self.vkFooter removeFromSuperview];
        self.vkFooter = nil;
    }
}


@end
