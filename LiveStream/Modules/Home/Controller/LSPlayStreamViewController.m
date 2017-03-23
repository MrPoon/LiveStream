//
//  LSPlayStreamViewController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/23.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSPlayStreamViewController.h"

@interface LSPlayStreamViewController ()
@property(nonatomic, strong) RACSignal *signal;
@end

@implementation LSPlayStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"1%@",[self.view class]);
        [subscriber sendNext:nil];
        return nil;
    }];
    [self.signal subscribeNext:^(id x) {
        NSLog(@"2%@",[self.view class]);
    }];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"panyangjun" forKey:@"name"];
    
    NSLog(@"fdsf d");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc
{
    NSLog(@"dealloc---%@",[self class]);
}
@end
