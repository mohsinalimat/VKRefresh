//
//  VKConstant.h
//  VKRefreshExample
//
//  Created by Vokie on 12/28/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#ifndef VKConstant_h
#define VKConstant_h

//常量定义
#define VKRefreshVersion 1.0

#define VKRefreshSrcName(name) [NSString stringWithFormat:@"VKRefresh.bundle/%@", name]

#define VKRefreshTextSelector(targetText, defaultText) targetText == nil ? defaultText : targetText

#define VKRefreshAnimationDuration 0.5

#define VKRefreshHeaderHeight 64.0

#define VKRefreshFooterHeight 64.0

#define VKRefreshContentOffset @"contentOffset"

#define VKRefreshContentSize @"contentSize"

#define VKRefreshUpdateTimeKey @"VKRefreshUpdatedTimeKey"

#define VKRefreshHeaderStateTextForIdle @"下拉即可刷新"
#define VKRefreshHeaderStateTextForPulling @"松开立即刷新"
#define VKRefreshHeaderStateTextForRefreshing @"正在刷新"

#define VKRefreshFooterStateTextForIdle @"上拉加载更多"
#define VKRefreshFooterStateTextForPulling @"松开立即加载"
#define VKRefreshFooterStateTextForRefreshing @"正在加载"


#endif /* VKConstant_h */
