//
//  LSHomeViewModel.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSHomeViewModel.h"

@implementation LSHomeViewCellModel

@end

@implementation LSHomeViewModel

+(LSHomeViewModel *)shareInstance
{
    static LSHomeViewModel *instance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [[LSHomeViewModel alloc] init];
    });
    return instance;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(RACSignal *)getCategoryInfos
{
    RACSignal *singal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[LSNetworkManager shareManager] requestWithPath:GATEGORYINFO
                                           requestParams:nil
                                             requestType:GET
                                         requestComplete:^(id respondObject, NSError *error) {
                                             if (!error) {
                                                 if (respondObject) {
                                                     NSMutableArray *categoryInfos = [NSMutableArray array];
                                                     for (NSDictionary *dic in respondObject) {
                                                         LSCategoryModel *categoryModel = [LSCategoryModel mj_objectWithKeyValues:dic];
                                                         [categoryInfos addObject:categoryModel];
                                                     }
                                                     self.categoryInfos = categoryInfos;
                                                 }
                                                 [subscriber sendNext:nil];
                                                 [subscriber sendCompleted];
                                             } else {
                                                 [subscriber sendNext:nil];
                                                 [subscriber sendError:nil];
                                             }
            
        }];
        
        return nil;
    }];
    return singal;
}

-(RACSignal *)getRecommendData
{
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //获取数据
        @weakify(self);
        NSString *urlStr = @"http://www.quanmin.tv/json/app/index/recommend/list-iphone.json";
        [[LSNetworkManager shareManager] requestWithPath:urlStr
                                           requestParams:nil
                                             requestType:GET
                                         requestComplete:^(id respondObject, NSError *error) {
                                             if (!error) {
                                                 NSArray *listData = [respondObject objectForKey:@"room"];
                                                 if (listData.count) {
                                                     @strongify(self);
                                                     self.recommendData = [NSMutableArray array];
                                                     for (NSDictionary *dic in listData) {
                                                         LSCategoryModel *categoryModel = [LSCategoryModel mj_objectWithKeyValues:dic];
                                                         if (categoryModel.list.count) {
                                                            [self.recommendData addObject:categoryModel];
                                                         }
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
