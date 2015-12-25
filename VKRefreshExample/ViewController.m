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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    
    [self.refreshTableView vk_addRefreshHeader];
    
    self.refreshTableView.rowHeight = 40;
    [self.refreshTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
//    [self addObserver:self forKeyPath:@"view.backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.refreshTableView.contentInset = UIEdgeInsetsMake(164, 0, 0, 0);
//        self.refreshTableView.contentOffset = CGPointMake(0, 0);
//    });
//    self.refreshTableView.contentInset = UIEdgeInsetsMake(164, 0, 0, 0);
    self.refreshTableView.contentOffset = CGPointMake(0, 90);
    self.refreshTableView.tableFooterView = [[UIView alloc]init];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"2222>>>%@", NSStringFromCGRect(scrollView.frame));
    NSLog(@">>>%@", NSStringFromCGPoint(scrollView.contentOffset));
    NSLog(@"111111>>>%@", NSStringFromUIEdgeInsets((scrollView.contentInset)));
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    NSLog(@">>keyPath>%@   >obj>>>%@   >>change>>%@", keyPath, object, change);
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.contentView.backgroundColor = [UIColor cyanColor];
    if (indexPath.row == 0) {
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
