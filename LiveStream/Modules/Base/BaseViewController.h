//
//  BaseViewController.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController

//loadingView
@property(nonatomic, strong) MBProgressHUD *progressHUD;

-(void)showLoadingWithTitle:(NSString *)title Animated:(BOOL)animated;

-(void)hideLoading;

@end
