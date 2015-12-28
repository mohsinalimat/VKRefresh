//
//  VKRefreshFooter.m
//  VKRefreshExample
//
//  Created by Vokie on 12/28/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#import "VKRefreshFooter.h"
#import "VKRefreshConstant.h"
#import "UIView+VKExtension.h"
#import "UIScrollView+VKExtension.h"

@interface VKRefreshFooter ()

@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) VKRefreshState oldState;
@end

@implementation VKRefreshFooter

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:VKRefreshSrcName(@"arrow")]];
        _arrowImage = arrowImage;
        _arrowImage.transform = CGAffineTransformMakeScale(1.0,-1.0);
        _arrowImage.alpha = 1.0f;
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator = indicator;
        _indicator.alpha = 0.0f;
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
    
    NSLog(@"HHH:%f    %f", self.scrollView.vk_offsetY + self.scrollView.vk_h, self.scrollView.vk_contentSizeHeight);
    if ([keyPath isEqualToString:VKRefreshContentOffset]) {
        NSLog(@"Content OffsetY:%f", self.scrollView.vk_offsetY);
        if (self.scrollView.isDragging) {
            if (self.state == VKRefreshStatePulling && self.scrollView.vk_offsetY + self.scrollView.vk_h < self.scrollView.vk_contentSizeHeight + VKRefreshFooterHeight) {
                self.state = VKRefreshStateIdle;
                NSLog(@">>>>>>>>>>>>>IDEL");
            }else if (self.state == VKRefreshStateIdle && self.scrollView.vk_offsetY + self.scrollView.vk_h > self.scrollView.vk_contentSizeHeight + VKRefreshFooterHeight) {  //上拉头部的距离
                self.state = VKRefreshStatePulling;
                NSLog(@">>>>>>>>>>>>>PULL");
            }
        }else{
            if (self.state == VKRefreshStatePulling) {
                self.state = VKRefreshStateRefreshing;
            }
        }
    }
}

- (void)setState:(VKRefreshState)state {
    _oldState = _state;
    _state = state;
    
    switch (state) {
        case VKRefreshStateIdle:{
            if (_oldState == VKRefreshStateRefreshing) {
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;   //恢复初始状态
                    self.scrollView.vk_insetBottom -= VKRefreshFooterHeight;   //tableView上滚，隐藏tableView头部
                    self.indicator.alpha = 0.0f;
                    self.arrowImage.alpha = 1.0f;
                }completion:^(BOOL finished) {
                    [self.indicator stopAnimating];
                }];
            }else{  //VKRefreshStatePulling
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;   //恢复初始状态
                }];
                
            }
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
                self.scrollView.vk_insetBottom = VKRefreshFooterHeight;
                self.scrollView.vk_offsetY = VKRefreshFooterHeight + self.scrollView.vk_contentSizeHeight - self.scrollView.vk_h; //tableview向上滚动footer的高度的距离
                self.arrowImage.alpha = 0.0f;
                self.indicator.alpha = 1.0f;
                [self.indicator startAnimating];
            } completion:^(BOOL finished) {
                if (self.footerRefreshing) {
                    self.footerRefreshing();
                }
            }];
            
            break;
        }default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        //设置header的高度
        self.vk_h = VKRefreshHeaderHeight;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    self.arrowImage.center = CGPointMake(10, 10);
    NSLog(@"footer  layout subviews is called");
    self.vk_y = self.scrollView.vk_contentSizeHeight;
    // 箭头
    CGFloat arrowX = self.vk_w * 0.5 - 100;
    NSLog(@"footer >>> %f", arrowX);
    self.arrowImage.center = CGPointMake(arrowX, self.vk_h * 0.5);
    self.indicator.center = self.arrowImage.center;
}

- (void)beginRefreshing {
    self.state = VKRefreshStateRefreshing;
}

- (void)endRefreshing {
    self.state = VKRefreshStateIdle;
}

@end
