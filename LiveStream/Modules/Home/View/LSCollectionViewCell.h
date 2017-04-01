//
//  LSCollectionViewCell.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/27.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLiveModel.h"
@interface LSCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) LSLiveModel *liveModel;
@end
