//
//  LSTableViewCell.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/29.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLiveModel.h"
@interface LSTableViewCell : UITableViewCell
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) LSCategoryModel *categoryModel;
@end
