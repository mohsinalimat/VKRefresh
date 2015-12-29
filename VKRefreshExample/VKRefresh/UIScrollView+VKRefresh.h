//
//  UIScrollView+VKRefresh.h
//  VKRefresh
//
//  Created by Vokie on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKRefreshHeader, VKRefreshFooter;

@interface UIScrollView (VKRefresh)

@property (nonatomic, readonly, weak) VKRefreshHeader *vkHeader;

- (void)vk_addRefreshHeader;

- (void)vk_removeRefreshHeader;

@property (nonatomic, readonly, weak) VKRefreshFooter *vkFooter;

- (void)vk_addRefreshFooter;

- (void)vk_removeRefreshFooter;

@end
