//
//  LSHomeViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSHomeViewController.h"
#import "LSHomeViewModel.h"
#import "LSHomeViewCell.h"
#import <objc/runtime.h>
#import "LSPlayStreamViewController.h"
@interface LSHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) LSHomeViewModel *viewModel;
@property(nonatomic, assign) NSUInteger pageCount;
@end

@implementation LSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前最热";
    [self.view addSubview:self.tableView];
    self.viewModel = [[LSHomeViewModel alloc] init];
    [self showLoadingWithTitle:@"加载中..." Animated:YES];
    self.pageCount = 1;
    [_tableView.mj_header beginRefreshing];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"number"] && (object == self.viewModel)) {
        NSLog(@"--------%ld",[self.viewModel.number integerValue]);
        NSLog(@"********%ld",[[change objectForKey:NSKeyValueChangeNewKey] integerValue]);
    }
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //reloadData
            self.pageCount = 1;//只刷新第一页内容
            [self refreshData];
        }];
        header.backgroundColor = [UIColor lightGrayColor];
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"下拉刷新" forState:MJRefreshStateWillRefresh];
        [header setTitle:@"加载中" forState:MJRefreshStateRefreshing];
        [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
        _tableView.mj_header = header;
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            self.pageCount ++;
            [self refreshData];
        }];
        footer.backgroundColor = [UIColor lightGrayColor];
        [footer setTitle:@"加载更多数据" forState:MJRefreshStateRefreshing];
        _tableView.mj_footer = footer;
        
    }
    return _tableView;
}

-(void)refreshData {
    @weakify(self);
    [[self.viewModel getAllLiveDataWithPageCount:self.pageCount] subscribeNext:^(id x) {
        @strongify(self);
        if ([x isKindOfClass:[NSString class]]) {
            NSLog(@"%@",x);
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self hideLoading];
    } error:^(NSError *error) {
        @strongify(self);
        //没有更多内容
        self.pageCount --;
    } completed:^{
        @strongify(self);
        [self.tableView reloadData];
        
        
        //
        NSMutableArray *dataSource = [NSMutableArray array];
        for (LSHomeViewCellModel *Model in self.viewModel.dataSource) {
            
            NSLog(@"-----%ld",[Model.title hash]);
            [dataSource addObject:@([Model.title hash])];
        }
         NSLog(@"-----");
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELLID";
    LSHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LSHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    LSHomeViewCellModel *cellModel = self.viewModel.dataSource[indexPath.row];
    cell.cellModel = cellModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 465;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPlayStreamViewController *vc = [[LSPlayStreamViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self removeObserver:self forKeyPath:@"number"];
}
-(void)dealloc
{
    NSLog(@"%@",[self class]);
}

@end
