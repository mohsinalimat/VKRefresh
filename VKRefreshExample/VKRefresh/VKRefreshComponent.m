//
//  VKRefreshComponent.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "VKRefreshComponent.h"
#import "VKRefreshConstant.h"
#import "UIView+VKExtension.h"

@interface VKRefreshComponent()

@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;

@end

@implementation VKRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    NSLog(@"VKRefreshComponent.willMoveToSuperview");
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:VKRefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:VKRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        // 设置宽度
        self.vk_w = newSuperview.vk_w;
        // 设置位置
        self.vk_x = 0;
        
        // 记录UIScrollView
        self.scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        self.scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
}

@end
