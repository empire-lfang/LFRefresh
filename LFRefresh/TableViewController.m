//
//  TableViewController.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/10.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "TableViewController.h"
#import "LFRefresh.h"
@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    __weak typeof (self)weakSelf = self;
    self.tableView.lf_headerView = [self.tableView addHeaderView:[[LFHeaderView alloc]init] handel:^{
        [weakSelf.tableView.lf_headerView endRefresh];
    }];
    self.tableView.lf_footerView = [self.tableView addFooterView:[[LFFooterView alloc]init] handel:^{
        [weakSelf.tableView.lf_footerView endRefresh];
    }];
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor purpleColor];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第-----%d------行",indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


@end
