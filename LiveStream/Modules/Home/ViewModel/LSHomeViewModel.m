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
@end

@implementation LSHomeViewModel
-(RACSignal *)getAllLiveData
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //获取数据
        //http://live.9158.com/Fans/GetHotLive?page=%ld
        
        
        
        return nil;
    }];
    return signal;
}

@end
