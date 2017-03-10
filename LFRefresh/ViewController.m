//
//  ViewController.m
//  LFRefresh
//
//  Created by daoxiu on 2017/3/8.
//  Copyright © 2017年 aowokeji. All rights reserved.
//

#import "ViewController.h"
#import "LFRefresh.h"
#import "TableViewController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITableView *newTableview;
@property(nonatomic,assign)NSInteger numbers;
@end

@implementation ViewController
-(UITableView *)newTableview{
    if (!_newTableview) {
        _newTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Height, Width, Height) style:UITableViewStylePlain];
        _newTableview.rowHeight = 60;
        _newTableview.delegate = self;
        _newTableview.dataSource = self;
        _newTableview.tableFooterView = [[UIView alloc]init];
        [_newTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _newTableview;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.rowHeight = 60;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.numbers = 20;
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.newTableview];
    __weak typeof (self)weakSelf = self;
    self.newTableview.lf_headerView = [self.newTableview addHeaderView:[[LFHeaderView alloc]init] handel:^{
        [weakSelf.newTableview.lf_headerView endRefresh];
        
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.newTableview.transform = CGAffineTransformIdentity;
            weakSelf.tableview.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {}];
    }];
    self.tableview.lf_footerView = [self.tableview addFooterView:[[LFFooterView alloc]init] handel:^{
        [weakSelf.tableview.lf_footerView endRefresh];
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.tableview.transform = CGAffineTransformMakeTranslation(0, -Height);
            weakSelf.newTableview.transform = CGAffineTransformMakeTranslation(0,-Height);
        } completion:^(BOOL finished) {}];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [NSString stringWithFormat:@"第----%d----行",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TableViewController *tvc = [s instantiateViewControllerWithIdentifier:@"TbaleViewVC"];
    [self.navigationController pushViewController:tvc animated:YES];

}
@end
