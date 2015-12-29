//
//  VKRefreshFooter.m
//  VKRefresh
//
//  Created by Vokie on 12/28/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#import "VKRefreshFooter.h"
#import "UIView+VKExtension.h"
#import "UIScrollView+VKExtension.h"
#import "VKConstant.h"

@interface VKRefreshFooter ()

@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) VKRefreshState oldState;
@property (nonatomic, assign) BOOL isMoveUpFooterView;
@property (nonatomic, assign) CGFloat insetValue;
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

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc]init];
        _stateLabel = stateLabel;
        _stateLabel.text = VKRefreshTextSelector(self.textIdleState, VKRefreshFooterStateTextForIdle);
        _stateLabel.textColor = [UIColor grayColor];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
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
        self.isMoveUpFooterView = NO;
        self.insetValue = 0;
    }
    return self;
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:VKRefreshContentOffset]) {
        if (self.scrollView.isDragging) {
            if (self.state == VKRefreshStatePulling && self.scrollView.vk_offsetY + self.scrollView.vk_h < [self footerOriginY] + VKRefreshFooterHeight) {
                self.state = VKRefreshStateIdle;
            }else if (self.state == VKRefreshStateIdle && self.scrollView.vk_offsetY + self.scrollView.vk_h > [self footerOriginY] + VKRefreshFooterHeight) {  //上拉头部的距离
                self.state = VKRefreshStatePulling;
            }
        }else{
            if (self.state == VKRefreshStatePulling) {
                self.state = VKRefreshStateRefreshing;
            }
        }
    }else if ([keyPath isEqualToString:VKRefreshContentSize]) { //当加载更多Cell后(ContentSize改变)，重新设定刷新脚部的位置
        self.vk_y = [self footerOriginY];
    }
}

- (CGFloat)footerOriginY {
    //当contentSize小于scrollView的高度时，取的是tableView的高度，这样就不会把脚部露出来
    return self.scrollView.vk_contentSizeHeight > self.scrollView.vk_h ? self.scrollView.vk_contentSizeHeight : self.scrollView.vk_h;
}

- (void)setState:(VKRefreshState)state {
    _oldState = _state;
    _state = state;
    
    switch (state) {
        case VKRefreshStateIdle:{
            if (_oldState == VKRefreshStateRefreshing) {
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;   //恢复初始状态
                    if (!self.isMoveUpFooterView) {
                        self.scrollView.vk_insetBottom -= (VKRefreshFooterHeight + self.insetValue);
                    }
                    
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
        }case VKRefreshStatePulling:{
            [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
            break;
        }case VKRefreshStateRefreshing:{
            if (self.scrollView.vk_contentSizeHeight + VKRefreshFooterHeight < self.scrollView.vk_h) {
                self.isMoveUpFooterView = YES;
                self.vk_y = self.scrollView.vk_h - VKRefreshFooterHeight;  //上移FooterView
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.arrowImage.alpha = 0.0f;
                    self.indicator.alpha = 1.0f;
                    [self.indicator startAnimating];
                } completion:^(BOOL finished) {
                    if (self.footerRefreshing) {
                        self.footerRefreshing();
                    }
                }];
            }else{
                self.isMoveUpFooterView = NO;
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.scrollView.vk_insetBottom = VKRefreshFooterHeight;
                    self.insetValue = 0;
                    if (self.scrollView.vk_contentSizeHeight < self.scrollView.vk_h) {  //临界值的处理
                        self.insetValue = self.scrollView.vk_h - self.scrollView.vk_contentSizeHeight;
                        self.scrollView.vk_insetBottom = VKRefreshFooterHeight + self.insetValue;
                    }
                    self.scrollView.vk_offsetY = VKRefreshFooterHeight + self.scrollView.vk_contentSizeHeight - self.scrollView.vk_h; //tableview向上滚动footer的高度的距离
                    
                    self.arrowImage.alpha = 0.0f;
                    self.indicator.alpha = 1.0f;
                    [self.indicator startAnimating];
                } completion:^(BOOL finished) {
                    if (self.footerRefreshing) {
                        self.footerRefreshing();
                    }
                }];
            }
            
            break;
        }default:
            break;
    }
    
    [self updateStateLabel];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:VKRefreshContentOffset context:nil];
    [self.superview removeObserver:self forKeyPath:VKRefreshContentSize context:nil];

    if (newSuperview) {
        //对当前UITableView添加新的监听
        [newSuperview addObserver:self forKeyPath:VKRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:VKRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        self.vk_h = VKRefreshFooterHeight;
    }
}

- (void)updateStateLabel {
    if (self.state == VKRefreshStateIdle) {
        self.stateLabel.text = VKRefreshTextSelector(self.textIdleState, VKRefreshFooterStateTextForIdle);
    }else if (self.state == VKRefreshStatePulling) {
        self.stateLabel.text = VKRefreshTextSelector(self.textPullingState, VKRefreshFooterStateTextForPulling);
    }else if (self.state == VKRefreshStateRefreshing) {
        self.stateLabel.text = VKRefreshTextSelector(self.textRefreshingState, VKRefreshFooterStateTextForRefreshing);
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.vk_y = [self footerOriginY];
    // 箭头
    CGFloat arrowX = self.vk_w * 0.5 - 80;
    self.arrowImage.center = CGPointMake(arrowX, self.vk_h * 0.5);
    self.indicator.center = self.arrowImage.center;
    
    self.stateLabel.frame = CGRectMake(0, self.arrowImage.vk_y + self.arrowImage.vk_h / 4.0, self.vk_w, 20);
}

- (void)beginRefreshing {
    self.state = VKRefreshStateRefreshing;
}

- (void)endRefreshing {
    self.state = VKRefreshStateIdle;
}

@end
