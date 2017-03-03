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
@property(nonatomic, strong) NSString *number;
@property(nonatomic, strong) NSString *content;
@end

@interface LSHomeViewModel : RVMViewModel
@property(nonatomic, strong) NSMutableArray *dataSource;
@end
