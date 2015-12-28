//
//  UIView+VKExtension.h
//  VKRefreshExample
//
//  Created by ci123 on 15/12/22.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VKExtension)

@property (nonatomic, assign) CGFloat vk_x;
@property (nonatomic, assign) CGFloat vk_y;
@property (nonatomic, assign) CGFloat vk_w;
@property (nonatomic, assign) CGFloat vk_h;
@property (nonatomic, assign) CGSize vk_size;
@property (nonatomic, assign) CGPoint vk_origin;
@property (nonatomic, readonly, assign) CGFloat vk_bottom;
@property (nonatomic, readonly, assign) CGFloat vk_right;

@end
