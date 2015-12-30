//
//  ViewController.m
//  VKRefreshExample
//
//  Created by Vokie on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "ViewController.h"
#import "VKRefresh.h"

@interface ViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *refreshTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger headerNums;
@property (nonatomic, assign) NSInteger footerNums;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    self.refreshTableView.tableFooterView = [[UIView alloc]init];
    
    self.dataArray = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 5; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%ld. 美味外卖", i]];
    }
    
    self.refreshTableView.rowHeight = 40;
    [self.refreshTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.headerNums = 1;
    self.footerNums = 1;
    //添加VKRefresh的例子
    [self addVKRefresh];
}

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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
