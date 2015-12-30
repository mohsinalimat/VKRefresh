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

@end

@implementation VKRefreshBase

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newScrollView {
    [super willMoveToSuperview:newScrollView];
    
    if (newScrollView) {
        // 设置拉伸控件的宽度
        self.vk_w = newScrollView.vk_w;
        // 设置拉伸控件的x位置
        self.vk_x = 0;
        // 对绑定了VKRefresh的UIScrollView控件进行保存
        self.scrollView = (UIScrollView *)newScrollView;
        self.scrollView.alwaysBounceVertical = YES;
    }
}

- (void)beginRefreshing {

}

- (void)endRefreshing {

}

@end
