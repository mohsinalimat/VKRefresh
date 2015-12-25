//
//  UIScrollView+VKExtension.m
//  VKRefreshExample
//
//  Created by Vokie on 12/25/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#import "UIScrollView+VKExtension.h"

@implementation UIScrollView (VKExtension)

- (CGFloat)vk_offsetX {
    return self.contentOffset.x;
}

- (void)setVk_offsetX:(CGFloat)vk_offsetX {
    CGPoint point = self.contentOffset;
    point.x = vk_offsetX;
    self.contentOffset = point;
}

- (CGFloat)vk_offsetY {
    return self.contentOffset.y;
}

- (void)setVk_offsetY:(CGFloat)vk_offsetY {
    CGPoint point = self.contentOffset;
    point.y = vk_offsetY;
    self.contentOffset = point;
}

- (CGFloat)vk_insetTop {
    return self.contentInset.top;
}

- (void)setVk_insetTop:(CGFloat)vk_insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = vk_insetTop;
    self.contentInset = inset;
}

- (CGFloat)vk_insetLeft {
    return self.contentInset.left;
}

- (void)setVk_insetLeft:(CGFloat)vk_insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = vk_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)vk_insetBottom {
    return self.contentInset.bottom;
}

- (void)setVk_insetBottom:(CGFloat)vk_insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = vk_insetBottom;
    self.contentInset = inset;
}

- (CGFloat)vk_insetRight {
    return self.contentInset.right;
}

- (void)setVk_insetRight:(CGFloat)vk_insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = vk_insetRight;
    self.contentInset = inset;
}

- (CGFloat)vk_contentSizeWidth {
    return self.contentSize.width;
}

- (void)setVk_contentSizeWidth:(CGFloat)vk_contentSizeWidth {
    CGSize size = self.contentSize;
    size.width = vk_contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)vk_contentSizeHeight {
    return self.contentSize.height;
}

- (void)setVk_contentSizeHeight:(CGFloat)vk_contentSizeHeight {
    CGSize size = self.contentSize;
    size.height = vk_contentSizeHeight;
    self.contentSize = size;
}


@end
