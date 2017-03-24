//
//  LSHomeViewModel.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import "LSLiveModel.h"

@interface LSHomeViewCellModel : NSObject
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, assign) NSUInteger startleveal;
@property(nonatomic, assign) NSUInteger number;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) UIImage *startImage;
@property(nonatomic, strong) LSLiveModel *liveModel;
@end

@interface LSHomeViewModel : RVMViewModel
@property(nonatomic, strong) NSMutableArray *categoryInfo;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) NSNumber *number;

-(RACSignal *)getAllLiveDataWithPageCount:(NSUInteger)pageCount;

@end
