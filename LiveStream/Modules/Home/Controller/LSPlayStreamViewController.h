//
//  LSPlayStreamViewController.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/23.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "BaseViewController.h"

@interface LSPlayStreamViewController : BaseViewController
@property(nonatomic, copy) void(^sendValue)(NSString *value);
@end
