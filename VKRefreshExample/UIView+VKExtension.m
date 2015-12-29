//
//  UIView+VKExtension.m
//  VKRefresh
//
//  Created by Vokie on 15/12/22.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "UIView+VKExtension.h"

@implementation UIView (VKExtension)

#pragma mark - x、y、宽、高
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

#pragma mark - 上、左、下、右
- (CGFloat)vk_top {
    return self.vk_y;
}

- (void)setVk_top:(CGFloat)vk_top {
    self.vk_y = vk_top;
}

- (CGFloat)vk_left {
    return self.vk_x;
}

- (void)setVk_left:(CGFloat)vk_left {
    self.vk_x = vk_left;
}

- (CGFloat)vk_bottom {
    return self.vk_y + self.vk_h;
}

- (void)setVk_bottom:(CGFloat)vk_bottom {
    CGFloat delta = vk_bottom - (self.vk_y + self.vk_h);
    self.vk_y += delta;
}

- (CGFloat)vk_right {
    return self.vk_x + self.vk_w;
}

- (void)setVk_right:(CGFloat)vk_right {
    CGFloat delta = vk_right - (self.vk_x + self.vk_w);
    self.vk_x += delta;
}

#pragma mark - Size、Origin
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
