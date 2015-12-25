//
//  UIScrollView+VKRefresh.h
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKRefreshHeader;

@interface UIScrollView (VKRefresh)

@property (nonatomic, weak, readonly) VKRefreshHeader *vkHeader;

- (void)vk_addRefreshHeader;

- (void)vk_removeRefreshHeader;

@end
