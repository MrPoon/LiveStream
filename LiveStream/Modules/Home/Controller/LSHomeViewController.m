//
//  LSHomeViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSHomeViewController.h"
#import "LSHomeViewModel.h"
@interface LSHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) LSHomeViewModel *viewModel;
@end

@implementation LSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[LSHomeViewModel alloc] init];
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELLID";

    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
