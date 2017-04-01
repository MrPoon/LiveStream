//
//  LSRecommendListViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/27.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSRecommendListViewController.h"
#import "LSCollectionViewCell.h"
#import "LSHomeViewModel.h"
#import "LSTableViewCell.h"
@interface LSRecommendListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation LSRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    @weakify(self);
    [[[LSHomeViewModel shareInstance] getRecommendData] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    self.tableView.backgroundColor = [UIColor grayColor];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 104) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark -collectionView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LSHomeViewModel shareInstance].recommendData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellid = @"cellid";
    LSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[LSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    LSCategoryModel *categoryModel = [[LSHomeViewModel shareInstance].recommendData objectAtIndex:indexPath.row];
    cell.categoryModel = categoryModel;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSCategoryModel *categoryModel = [[LSHomeViewModel shareInstance].recommendData objectAtIndex:indexPath.row];
    CGFloat height = ((kScreen_Width-30)/2) * 3 / 5 + 30;
    return categoryModel.list.count / 2 * height + 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
