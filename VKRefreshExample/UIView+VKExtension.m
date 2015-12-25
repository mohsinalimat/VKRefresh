//
//  UIView+VKExtension.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/22.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "UIView+VKExtension.h"

@implementation UIView (VKExtension)

- (CGFloat)vk_x {
    return self.frame.origin.x;
}

- (void)setVk_x:(CGFloat)vk_x {
    CGRect frame = self.frame;
    frame.origin.x = vk_x;
    self.frame = frame;
}

- (CGFloat)vk_y {
    return self.frame.origin.y;
}

- (void)setVk_y:(CGFloat)vk_y {
    CGRect frame = self.frame;
    frame.origin.y = vk_y;
    self.frame = frame;
}

- (CGFloat)vk_w {
    return self.frame.size.width;
}

- (void)setVk_w:(CGFloat)vk_w {
    CGRect frame = self.frame;
    frame.size.width = vk_w;
    self.frame = frame;
}

- (CGFloat)vk_h {
    return self.frame.size.height;
}

- (void)setVk_h:(CGFloat)vk_h {
    CGRect frame = self.frame;
    frame.size.height = vk_h;
    self.frame = frame;
}

- (CGSize)vk_size {
    return self.frame.size;
}

- (void)setVk_size:(CGSize)vk_size {
    CGRect frame = self.frame;
    frame.size = vk_size;
    self.frame = frame;
}

- (CGPoint)vk_origin {
    return self.frame.origin;
}

- (void)setVk_origin:(CGPoint)vk_origin {
    CGRect frame = self.frame;
    frame.origin = vk_origin;
    self.frame = frame;
}

@end
