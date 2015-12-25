//
//  VKRefreshComponent.h
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VKRefreshState) {
    VKRefreshStateIdle = 1,   //普通状态
    VKRefreshStatePulling,   //拉伸状态
    VKRefreshStateRefreshing  //正在刷新
};

@interface VKRefreshComponent : UIView

@property (weak, nonatomic) UIScrollView *scrollView;

@end
