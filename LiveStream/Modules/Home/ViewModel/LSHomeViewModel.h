//
//  LSHomeViewModel.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@interface LSHomeViewCellModel : NSObject

@end

@interface LSHomeViewModel : RVMViewModel
@property(nonatomic, strong) NSMutableArray *dataSource;
@end
