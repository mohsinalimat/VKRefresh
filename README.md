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
    self.refreshTableView.vkHeader.textIdleState = @"拉我一把呀";
    self.refreshTableView.vkHeader.textPullingState = @"别拉我啦";
    self.refreshTableView.vkHeader.textRefreshingState = @"奔跑加载中";
    
    //立刻执行头部刷新
    //[self.refreshTableView.vkHeader beginRefreshing];
    
    self.refreshTableView.vkHeader.headerRefreshing = ^{
        //假装在请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray insertObject:@"header_1001" atIndex:0];
            [self.dataArray insertObject:@"header_1002" atIndex:0];
            [self.dataArray insertObject:@"header_1003" atIndex:0];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止头部刷新
            [self.refreshTableView.vkHeader endRefreshing];
        });
    };
    
    //添加刷新脚部
    [self.refreshTableView vk_addRefreshFooter];
    self.refreshTableView.vkFooter.textIdleState = @"继续上拉我";
    self.refreshTableView.vkFooter.textPullingState = @"松开我吧";
    self.refreshTableView.vkFooter.textRefreshingState = @"火速加载中";
    
    self.refreshTableView.vkFooter.footerRefreshing = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray addObject:@"footer_9991"];
            [self.dataArray addObject:@"footer_9992"];
            [self.dataArray addObject:@"footer_9993"];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止脚部刷新
            [self.refreshTableView.vkFooter endRefreshing];
        });
    };
}
```

备注:VKRefresh代码将持续重构优化，提高代码质量、代码效率、编码风格。欢迎各位GitHub Coder指导。


