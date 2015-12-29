//
//  VKRefreshHeader.m
//  VKRefresh
//
//  Created by Vokie on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "VKRefreshHeader.h"
#import "UIView+VKExtension.h"
#import "UIScrollView+VKExtension.h"
#import "VKConstant.h"

@interface VKRefreshHeader()

@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) VKRefreshState oldState;

@end

@implementation VKRefreshHeader

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:VKRefreshSrcName(@"arrow")]];
        _arrowImage = arrowImage;
        _arrowImage.alpha = 1.0f;
        [self addSubview:_arrowImage];
    }
    return _arrowImage;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *timeLabel = [[UILabel alloc]init];
        _timeLabel = timeLabel;
        _timeLabel.text = @"最后更新：无记录";
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];
        [self updatedTimeLabel];
    }
    return _timeLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc]init];
        _stateLabel = stateLabel;
        _stateLabel.text = VKRefreshTextSelector(self.textIdleState, VKRefreshHeaderStateTextForIdle);
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
    }
    return self;
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:VKRefreshContentOffset]) {
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
    _oldState = _state;
    _state = state;
    
    switch (state) {
        case VKRefreshStateIdle:{
            if (_oldState == VKRefreshStateRefreshing) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:VKRefreshUpdateTimeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self updatedTimeLabel];
                
                [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;   //恢复初始状态
                    self.scrollView.vk_insetTop -= VKRefreshHeaderHeight;   //tableView上滚，隐藏tableView头部
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
            [UIView animateWithDuration:VKRefreshAnimationDuration animations:^{
                self.scrollView.vk_insetTop = VKRefreshHeaderHeight;
                self.scrollView.vk_offsetY = -VKRefreshHeaderHeight;   //tableview向下滚动header的高度距离
                self.arrowImage.alpha = 0.0f;
                self.indicator.alpha = 1.0f;
                [self.indicator startAnimating];
            } completion:^(BOOL finished) {
                if (self.headerRefreshing) {
                    self.headerRefreshing();
                }
            }];
            
            break;
        }default:
            break;
    }
    [self updateStateLabel];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:VKRefreshContentOffset context:nil];
    if (newSuperview) {
        //对当前UITableView添加新的监听
        [newSuperview addObserver:self forKeyPath:VKRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        //设置header的高度
        self.vk_h = VKRefreshHeaderHeight;
    }
}

- (void)updateStateLabel {
    if (self.state == VKRefreshStateIdle) {
        self.stateLabel.text = VKRefreshTextSelector(self.textIdleState, VKRefreshHeaderStateTextForIdle);
    }else if (self.state == VKRefreshStatePulling) {
        self.stateLabel.text = VKRefreshTextSelector(self.textPullingState, VKRefreshHeaderStateTextForPulling);
    }else if (self.state == VKRefreshStateRefreshing) {
        self.stateLabel.text = VKRefreshTextSelector(self.textRefreshingState, VKRefreshHeaderStateTextForRefreshing);
    }
}


#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark key的处理
- (void)updatedTimeLabel {
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:VKRefreshUpdateTimeKey];
    
    if (lastUpdatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        // 3.显示日期
        self.timeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
    } else {
        self.timeLabel.text = @"最后更新：无记录";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.vk_y = -self.vk_h;
    // 箭头
    CGFloat arrowX = self.vk_w * 0.5 - 80;
    self.arrowImage.center = CGPointMake(arrowX, self.vk_h * 0.5);
    self.indicator.center = self.arrowImage.center;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(0, self.arrowImage.vk_y + self.arrowImage.vk_h / 2.0, self.vk_w, 15);
    self.stateLabel.frame = CGRectMake(0, self.arrowImage.vk_y, self.vk_w, 15);
}

- (void)beginRefreshing {
    self.state = VKRefreshStateRefreshing;
}

- (void)endRefreshing {
    self.state = VKRefreshStateIdle;
}

@end
