//
//  UIView+VKExtension.h
//  VKRefresh
//
//  Created by Vokie on 15/12/22.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VKExtension)

@property (nonatomic, assign) CGFloat vk_x;
@property (nonatomic, assign) CGFloat vk_y;
@property (nonatomic, assign) CGFloat vk_w;
@property (nonatomic, assign) CGFloat vk_h;

@property (nonatomic, assign) CGFloat vk_top;
@property (nonatomic, assign) CGFloat vk_left;
@property (nonatomic, assign) CGFloat vk_bottom;
@property (nonatomic, assign) CGFloat vk_right;

@property (nonatomic, assign) CGSize vk_size;
@property (nonatomic, assign) CGPoint vk_origin;
@end
