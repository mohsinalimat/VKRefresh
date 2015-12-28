//
//  ViewController.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "ViewController.h"
#import "VKRefresh.h"

@interface ViewController()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *refreshTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", nil];
    
    //添加刷新头部
    [self.refreshTableView vk_addRefreshHeader];
    
//    [self.refreshTableView.vkHeader beginRefreshing];
    
    self.refreshTableView.vkHeader.headerRefreshing = ^{
        //假装在请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    self.refreshTableView.vkFooter.footerRefreshing = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray addObject:@"footer_9991"];
            [self.dataArray addObject:@"footer_9992"];
            [self.dataArray addObject:@"footer_9993"];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止脚部刷新
            [self.refreshTableView.vkFooter endRefreshing];
        });
    };
    
    
    self.refreshTableView.rowHeight = 40;
    [self.refreshTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
//    [self addObserver:self forKeyPath:@"view.backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.refreshTableView.contentInset = UIEdgeInsetsMake(164, 0, 0, 0);
//        self.refreshTableView.contentOffset = CGPointMake(0, 0);
//    });
//    self.refreshTableView.contentInset = UIEdgeInsetsMake(164, 0, 0, 0);
//    self.refreshTableView.contentOffset = CGPointMake(0, 90);
//    self.refreshTableView.tableFooterView = [[UIView alloc]init];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"2222>>>%@", NSStringFromCGRect(scrollView.frame));
//    NSLog(@">>>%@", NSStringFromCGPoint(scrollView.contentOffset));
//    NSLog(@"111111>>>%@", NSStringFromUIEdgeInsets((scrollView.contentInset)));
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    NSLog(@">>keyPath>%@   >obj>>>%@   >>change>>%@", keyPath, object, change);
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor grayColor];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@">>>%@", self.dataArray[indexPath.row]];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
