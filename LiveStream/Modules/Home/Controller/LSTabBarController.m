//
//  LSTabBarController.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/2.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSTabBarController.h"
#import "LSHomeViewController.h"
#import "BaseNavigationController.h"
@interface LSTabBarController ()

@end

@implementation LSTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    
    self.tabBar.backgroundColor = HexRGB(0xffffff);
    
    [[UITabBarItem appearanceWhenContainedIn:[LSTabBarController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:253/255.0 green:198/255.0 blue:199/255.0 alpha:1.0] } forState:UIControlStateNormal];
    
    [[UITabBarItem appearanceWhenContainedIn:[LSTabBarController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:252/255.0 green:84/255.0 blue:88/255.0 alpha:1.0] } forState:UIControlStateSelected];
}

- (void)setup
{
    [self addChildViewController:[[LSHomeViewController alloc]init] title:@"首页" normalImageNamed:@"btn_tabbar_home_normal_25x25_" selectedImageName:@"btn_tabbar_home_selected_25x25_"];
    
    [self addChildViewController:[[UIViewController alloc] init] title:@"栏目" normalImageNamed:@"btn_tabbar_lanmu_normal_25x25_" selectedImageName:@"btn_tabbar_lanmu_selected_25x25_"];
    
    [self addChildViewController:[[UIViewController alloc]init] title:@"直播" normalImageNamed:@"btn_tabbar_zhibo_normal_25x25_" selectedImageName:@"btn_tabbar_zhibo_selected_25x25_"];
    
    [self addChildViewController:[[UIViewController alloc]init] title:@"我的" normalImageNamed:@"btn_tabbar_wode_normal_25x25_" selectedImageName:@"btn_tabbar_wode_selected_25x25_"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString*)title normalImageNamed:(NSString *)imageName selectedImageName:(NSString*)selectedImageName
{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    childController.title = title;
    if ([title isEqualToString:@"首页"])
        {
        [nav.navigationBar setShadowImage:[[UIImage alloc]init]];
        childController.title = @"";
        }
    childController.tabBarItem.title = title;
    //声明显示图片的原始式样 不要渲染
    childController.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]
                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    childController.tabBarItem.imageInsets = UIEdgeInsetsZero;
    [self addChildViewController:nav];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
