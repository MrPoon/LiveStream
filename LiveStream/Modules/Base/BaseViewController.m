//
//  BaseViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"我是原始的");
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - loadingView

-(void)showLoadingWithTitle:(NSString *)title Animated:(BOOL)animated {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    _progressHUD.removeFromSuperViewOnHide = YES;
    if (title) {
        _progressHUD.labelText = title;
    }
    [self.view addSubview:_progressHUD];
    [_progressHUD show:animated];
}
-(void)hideLoading {
    if (_progressHUD) {
        [_progressHUD hide:YES];
    }
}

@end
