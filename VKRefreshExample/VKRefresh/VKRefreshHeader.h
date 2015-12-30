//
//  VKRefreshHeader.h
//  VKRefresh
//
//  Created by Vokie on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKRefreshBase.h"

@interface VKRefreshHeader : VKRefreshBase

@property (nonatomic, assign) VKRefreshState state;
//拉动过程中的状态文字描述
@property (nonatomic, retain) NSString *textIdleState;
@property (nonatomic, retain) NSString *textPullingState;
@property (nonatomic, retain) NSString *textRefreshingState;
@end
