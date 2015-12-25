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

@interface VKRefreshHeader()

@property (nonatomic, weak) UIImageView *arrowImage;

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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        newSuperview.vk_h = VKRefreshHeaderHeight;
    }
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:VKRefreshContentOffset]) {
        NSLog(@">>>>>do some thing");
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
//    self.arrowImage.center = CGPointMake(10, 10);
    NSLog(@"header  layout subviews is called");
    
    // 箭头
    CGFloat arrowX = self.vk_w * 0.5 - 100;
    NSLog(@">>>%f", arrowX);
    self.arrowImage.center = CGPointMake(arrowX, self.vk_h * 0.5);
    
}

@end
