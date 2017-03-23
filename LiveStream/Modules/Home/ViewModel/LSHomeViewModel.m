//
//  LSHomeViewModel.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSHomeViewModel.h"
@implementation LSHomeViewCellModel
-(UIImage *)startImage
{
    if (self.startleveal) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19", self.startleveal]];
    }
    return nil;
}
-(void)setLiveModel:(LSLiveModel *)liveModel
{
    _liveModel = liveModel;
    self.avatar = liveModel.smallpic;
    self.title = liveModel.myname;
    self.address = liveModel.gps;
    self.startleveal = liveModel.starlevel;
    self.number = liveModel.allnum;
    self.content = liveModel.bigpic;
}
@end

@implementation LSHomeViewModel

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(RACSignal *)getAllLiveDataWithPageCount:(NSUInteger)pageCount
{
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //获取数据
        @weakify(self);
        NSString *urlStr = [NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",pageCount];
        [[LSNetworkManager shareManager] requestWithPath:urlStr
                                           requestParams:nil
                                             requestType:GET
                                         requestComplete:^(id respondObject, NSError *error) {
                                             if (!error) {
                                                 NSArray *listData = [[respondObject objectForKey:@"data"] objectForKey:@"list"];
                                                 if (listData.count) {
                                                     @strongify(self);
                                                     for (NSDictionary *dic in listData) {
                                                         LSLiveModel *liveModel = [LSLiveModel mj_objectWithKeyValues:dic];
                                                         LSHomeViewCellModel *cellModel = [[LSHomeViewCellModel alloc] init];
                                                         cellModel.liveModel = liveModel;
                                                         [self.dataSource addObject:cellModel];
                                                         self.number = @(self.dataSource.count);
                                                     }
                                                     [subscriber sendNext:nil];
                                                     [subscriber sendCompleted];
                                                 } else {
                                                     [subscriber sendNext:@"loadfail"];
                                                     [subscriber sendError:nil];
                                                 }
                                             }else {
                                                 [subscriber sendNext:@"loadfail"];
                                                 [subscriber sendError:nil];
                                             }
                                         }];
        
        
        return nil;
    }];
    return signal;
}

@end
