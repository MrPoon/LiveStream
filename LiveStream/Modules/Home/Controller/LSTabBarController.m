//
//  LSTabBarController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSTabBarController.h"
@interface LSTabBarController ()

@end

@implementation LSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *homeVC = [[UIViewController alloc] init];
    [self addChildVC:homeVC andImageName:@"toolbar_home"];
    UIViewController *liveVC = [[UIViewController alloc] init];
    [self addChildVC:liveVC andImageName:@"toolbar_live"];
    UIViewController *meVC = [[UIViewController alloc] init];
    [self addChildVC:meVC andImageName:@"toolbar_me"];
}

-(void)addChildVC:(UIViewController *)childViewController andImageName:(NSString *)imageName
{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childViewController];
    childViewController.tabBarItem.image = [UIImage imageNamed:imageName];
    childViewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    // 设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
    childViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
