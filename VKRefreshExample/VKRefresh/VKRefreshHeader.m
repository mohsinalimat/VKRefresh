//
//  VKRefreshHeader.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "VKRefreshHeader.h"
#import "VKRefreshConstant.h"
#import "UIView+VKExtension.h"
#import "UIScrollView+VKExtension.h"

@interface VKRefreshHeader()

@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;

@end

@implementation VKRefreshHeader

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:VKRefreshSrcName(@"arrow")]];
        _arrowImage = arrowImage;
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator = indicator;
        _indicator.hidden = YES;
        [self addSubview:_indicator];
    }
    return _indicator;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.state = VKRefreshStateIdle;   //默认初始化为Idle状态
    }
    return self;
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:VKRefreshContentOffset]) {
        NSLog(@"Content OffsetY:%f", self.scrollView.vk_offsetY);
        if (self.scrollView.isDragging) {
            if (self.state == VKRefreshStatePulling && self.scrollView.vk_offsetY > -VKRefreshHeaderHeight) {
                self.state = VKRefreshStateIdle;
            }else if (self.state == VKRefreshStateIdle && self.scrollView.vk_offsetY < -VKRefreshHeaderHeight) {  //下拉头部的距离
                self.state = VKRefreshStatePulling;
            }
        }else{
            if (self.state == VKRefreshStatePulling) {
                self.state = VKRefreshStateRefreshing;
            }
        }
        
        
    }
}

- (void)setState:(VKRefreshState)state {
    _state = state;
    
    switch (state) {
        case VKRefreshStateIdle:{
            [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;   //恢复初始状态
            }];
            break;
        }
        case VKRefreshStatePulling: {
            [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
            break;
        }case VKRefreshStateRefreshing: {
            NSLog(@"REfreshing....");
            [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                self.scrollView.vk_insetTop = VKRefreshHeaderHeight;
                self.scrollView.vk_offsetY = -VKRefreshHeaderHeight;
                self.arrowImage.hidden = YES;
                self.indicator.hidden = NO;
                [self.indicator startAnimating];
            } completion:^(BOOL finished) {
                
            }];
            
            break;
        }default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.vk_h = VKRefreshHeaderHeight;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.arrowImage.center = CGPointMake(10, 10);
    NSLog(@"header  layout subviews is called");
    self.vk_y = -self.vk_h;
    // 箭头
    CGFloat arrowX = self.vk_w * 0.5 - 100;
    NSLog(@">>>%f", arrowX);
    self.arrowImage.center = CGPointMake(arrowX, self.vk_h * 0.5);
    self.indicator.center = self.arrowImage.center;
    
}

@end
