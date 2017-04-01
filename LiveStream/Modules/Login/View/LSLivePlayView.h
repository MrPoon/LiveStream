//
//  LSLivePlayView.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/30.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSLivePlayView : UIView
@property(nonatomic, strong) RACSignal *exitPlaySignal;
@property(nonatomic, strong) RACSignal *fullScreenSignal;
- (instancetype)initWithFrame:(CGRect)frame WithURLString:(NSString*)aUrlString;
-(void)updateOnlineNumberWith:(NSString *)numberStr;

@end
