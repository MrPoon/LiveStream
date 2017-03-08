//
//  LSHomeViewModel.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@interface LSHomeViewCellModel : NSObject
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, assign) NSUInteger startleveal;
@property(nonatomic, assign) NSUInteger number;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) UIImage *startImage;
@end

@interface LSHomeViewModel : RVMViewModel
@property(nonatomic, strong) NSMutableArray *dataSource;

-(RACSignal *)getAllLiveData;

@end
