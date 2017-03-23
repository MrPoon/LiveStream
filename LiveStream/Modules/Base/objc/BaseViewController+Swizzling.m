//
//  BaseViewController+Swizzling.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/22.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "BaseViewController+Swizzling.h"

@implementation BaseViewController (Swizzling)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self MethodExchangeWithOriginMethod:@selector(viewWillAppear:) andSwizzlingMethod:@selector(custonViewWillAppear:) andIsInstanceMethod:YES];
    });
}

-(void)custonViewWillAppear:(BOOL)animated {
    [self custonViewWillAppear:animated];
    NSLog(@"我是替换的新方法");
}

@end
