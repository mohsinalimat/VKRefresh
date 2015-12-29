//
//  VKRefreshBase.m
//  VKRefresh
//
//  Created by Vokie on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "VKRefreshBase.h"
#import "UIView+VKExtension.h"
#import "VKConstant.h"

@interface VKRefreshBase()

@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;

@end

@implementation VKRefreshBase

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {        
        // 设置Header的宽度
        self.vk_w = newSuperview.vk_w;
        // 设置Header的x位置
        self.vk_x = 0;
        
        // 对UITableView进行保存
        self.scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        self.scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
}

- (void)beginRefreshing {

}

- (void)endRefreshing {

}

@end
