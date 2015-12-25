//
//  UIScrollView+VKExtension.h
//  VKRefreshExample
//
//  Created by Vokie on 12/25/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (VKExtension)

@property (nonatomic, assign) CGFloat vk_offsetX;
@property (nonatomic, assign) CGFloat vk_offsetY;

@property (nonatomic, assign) CGFloat vk_insetTop;
@property (nonatomic, assign) CGFloat vk_insetLeft;
@property (nonatomic, assign) CGFloat vk_insetBottom;
@property (nonatomic, assign) CGFloat vk_insetRight;

@property (nonatomic, assign) CGFloat vk_contentSizeWidth;
@property (nonatomic, assign) CGFloat vk_contentSizeHeight;


@end
