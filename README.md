## VKRefresh
(The README of English).

iOS平台上，一个下拉刷新，上拉加载更多的第三方控件。

功能:实现UITableView的刷新加载操作。

集成:将VKRefresh的文件夹添加到你项目下，添加`#import "VKRefresh.h"`声明。具体可以参考实例程序。

使用方法:
```objc
- (void)addVKRefresh {
    //添加刷新头部
    [self.refreshTableView vk_addRefreshHeader];
    self.refreshTableView.vkHeader.textIdleState = @"我要看菜单";
    self.refreshTableView.vkHeader.textPullingState = @"松开查看菜单";
    self.refreshTableView.vkHeader.textRefreshingState = @"可口美味准备中";
    
    //立刻执行头部刷新
    //[self.refreshTableView.vkHeader beginRefreshing];
    
    self.refreshTableView.vkHeader.headerRefreshing = ^{
        //假装在请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray insertObject:[NSString stringWithFormat:@"新增:肉汁面条:%ld", self.headerNums++] atIndex:0];
            [self.dataArray insertObject:[NSString stringWithFormat:@"新增:牛肉烧饭:%ld", self.headerNums++] atIndex:0];
            [self.dataArray insertObject:[NSString stringWithFormat:@"新增:三鲜混沌:%ld", self.headerNums++] atIndex:0];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止头部刷新
            [self.refreshTableView.vkHeader endRefreshing];
        });
    };
    
    //添加刷新脚部
    [self.refreshTableView vk_addRefreshFooter];
    self.refreshTableView.vkFooter.textIdleState = @"我要看饮料";
    self.refreshTableView.vkFooter.textPullingState = @"松开查看饮料";
    self.refreshTableView.vkFooter.textRefreshingState = @"新鲜饮料准备中";
    
    self.refreshTableView.vkFooter.footerRefreshing = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray addObject:[NSString stringWithFormat:@"更多:可口可乐:%ld", self.footerNums++]];
            [self.dataArray addObject:[NSString stringWithFormat:@"更多:营养快线:%ld", self.footerNums++]];
            [self.dataArray addObject:[NSString stringWithFormat:@"更多:牛奶果汁:%ld", self.footerNums++]];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止脚部刷新
            [self.refreshTableView.vkFooter endRefreshing];
        });
    };
    //立刻执行头部刷新
    //[self.refreshTableView.vkFooter beginRefreshing];
}
```

备注:VKRefresh代码将持续重构优化，提高代码质量、代码效率、编码风格。欢迎各位GitHub Coder指导。


