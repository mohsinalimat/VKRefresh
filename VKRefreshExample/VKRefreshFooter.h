//
//  VKRefreshFooter.h
//  VKRefresh
//
//  Created by Vokie on 12/28/15.
//  Copyright © 2015 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKRefreshBase.h"

@interface VKRefreshFooter : VKRefreshBase

@property (nonatomic, assign) VKRefreshState state;
//拉动过程中的状态文字描述
@property (nonatomic, retain) NSString *textIdleState;
@property (nonatomic, retain) NSString *textPullingState;
@property (nonatomic, retain) NSString *textRefreshingState;
@end
